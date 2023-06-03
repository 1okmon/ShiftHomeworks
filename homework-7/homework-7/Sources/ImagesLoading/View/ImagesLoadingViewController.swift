//
//  ViewController.swift
//  homework7
//
//  Created by 1okmon on 26.05.2023.
//

import UIKit

private enum Metrics {
    static let backgroundColor = UIColor.white
    enum TableViewCellAlert {
        static let titleForLoaded = "Картинка успешно загружена"
        static let titleForFailed = "Не удалось загрузить картинку"
        static let message = "Выберете действие"
        
        enum ActionTitle {
            static let delete = "Удалить"
            static let save = "Сохранить"
            static let unSave = "Убрать из сохраненных"
            static let close = "Закрыть"
        }
    }
    
    enum UrlFieldAlert {
        case emptyUrlField
        case wrongUrl
        
        var title: String {
            switch self {
            case .emptyUrlField:
                return "Ссылка не была указана"
            case .wrongUrl:
                return "Url не существует"
            }
        }
        
        var message: String {
            switch self {
            case .emptyUrlField:
                return "Пожалуйста укажите ссылку"
            case .wrongUrl:
                return "Кажется вы неверно ввели ссылку"
            }
        }
        
        var buttonTitle: String {
            "Закрыть"
        }
    }
}

final class ImagesLoadingViewController: UIViewController, IObserver {
    var id: UUID
    private let viewWithTable: ImagesLoadingView
    private var viewModel: IImagesLoadingViewModel?
    private var selectedImageSaveStatus: ImageStatusInCoreData?
    
    init() {
        self.id = UUID()
        self.viewWithTable = ImagesLoadingView()
        super.init(nibName: nil, bundle: nil)
    }
    
    func setViewModel(viewModel: IImagesLoadingViewModel) {
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Metrics.backgroundColor
        configure()
        self.viewModel?.launch()
    }
    
    func update<T>(with value: T) {
        if let isUrlCreated = value as? Bool {
            if !isUrlCreated {
                showAlert(.wrongUrl)
            }
        }
        if let saveStatus = value as? ImageStatusInCoreData {
            self.selectedImageSaveStatus = saveStatus
        }
        guard let value = value as? [UUID: LoadingState] else { return }
        self.viewWithTable.update(to: value)
    }
}

private extension ImagesLoadingViewController {
    func configure() {
        configureView()
    }
    
    func configureView() {
        self.view.addSubview(viewWithTable)
        self.viewWithTable.snp.makeConstraints { make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide.snp.edges)
        }
        self.viewWithTable.tableViewCellAlertHandler = { [weak self] imageId, state in
            self?.viewModel?.detectSaveStatusForImage(by: imageId)
            self?.showAlertSheetForTableViewCell(with: imageId, for: state)
        }
        self.viewWithTable.loadButtonTapHandler = { [weak self] imageId, url in
            guard !url.isEmpty else {
                self?.showAlert(.emptyUrlField)
                return
            }
            self?.viewModel?.load(from: url, imageId: imageId)
        }
        self.viewWithTable.pauseTapHandler = { [weak self] imageId in
            self?.viewModel?.switchPause(with: imageId)
        }
    }
    
    func showAlertSheetForTableViewCell(with imageId: UUID, for state: LoadingState?) {
        let alertActions = alertActionsForCell(with: imageId, for: state)
        var title = Metrics.TableViewCellAlert.titleForLoaded
        if case .error = state {
            title = Metrics.TableViewCellAlert.titleForFailed
        }
        let alert = UIAlertController(title: title,
                                      message: Metrics.TableViewCellAlert.message,
                                      preferredStyle: .actionSheet)
        alertActions.forEach { alert.addAction($0) }
        self.present(alert, animated: true)
    }
    
    func showAlert(_ type: Metrics.UrlFieldAlert) {
        let alert = UIAlertController(title: type.title,
                                      message: type.message,
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: type.buttonTitle, style: .cancel)
        alert.addAction(action)
        self.present(alert, animated: true)
    }
    
    func alertActionsForCell(with imageId: UUID, for state: LoadingState?) -> [UIAlertAction] {
        var alertActions: [UIAlertAction] = []
        let delete = UIAlertAction(title: Metrics.TableViewCellAlert.ActionTitle.delete, style: .destructive) { [weak self] _ in
            self?.viewModel?.delete(with: imageId)
        }
        alertActions.append(delete)
        
        if case .loaded = state {
            var save = UIAlertAction(title: Metrics.TableViewCellAlert.ActionTitle.save, style: .default) { [weak self] _ in
                self?.viewModel?.saveImage(with: imageId)
            }
            if case .saved = self.selectedImageSaveStatus {
                save = UIAlertAction(title: Metrics.TableViewCellAlert.ActionTitle.unSave, style: .default) { [weak self] _ in
                    self?.viewModel?.deleteFromDB(with: imageId)
                }
            }
            alertActions.append(save)
        }
        let close = UIAlertAction(title: Metrics.TableViewCellAlert.ActionTitle.close, style: .cancel)
        alertActions.append(close)
        return alertActions
    }
}
