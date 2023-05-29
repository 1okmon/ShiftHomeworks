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
        static let title = "Не удалось загрузить картинку"
        static let message = "Выберете действие"
    }
    
    enum WrongUrlAlert {
        static let title = "Url не существует"
        static let message = "Кажется вы неверно ввели ссылку"
        static let buttonTitle = "Закрыть"
    }
}

final class ImagesLoadingViewController: UIViewController, IObserver {
    var id: UUID
    private let viewWithTable: ImagesLoadingView
    private var viewModel: IImagesLoadingViewModel?
    
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
    }
    
    func update<T>(with value: T) {
        guard let value = value as? [UUID: LoadingState] else { return }
        viewWithTable.update(to: value)
    }
}

private extension ImagesLoadingViewController {
    func configure() {
        configureView()
    }
    
    func configureView() {
        self.view.addSubview(viewWithTable)
        viewWithTable.snp.makeConstraints { make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide.snp.edges)
        }
        viewWithTable.tableViewCellAlertHandler = { [weak self] alertActions in
            self?.showAlertSheetForTableViewCell(with: alertActions)
        }
        viewWithTable.wrongUrlAlertHandler = { [weak self] in
            self?.showAlert()
        }
        viewWithTable.loadButtonTapHandler = { [weak self] imageId, url in
            self?.viewModel?.load(from: url, imageId: imageId)
        }
        viewWithTable.pauseTapHandler = { [weak self] imageId in
            self?.viewModel?.switchPause(with: imageId)
        }
        viewWithTable.deleteTapHandler = { [weak self] imageId in
            self?.viewModel?.delete(with: imageId)
        }
    }
    
    func showAlertSheetForTableViewCell(with actions: [UIAlertAction]) {
        let alert = UIAlertController(title: Metrics.TableViewCellAlert.title,
                                      message: Metrics.TableViewCellAlert.message,
                                      preferredStyle: .actionSheet)
        actions.forEach { alert.addAction($0) }
        self.present(alert, animated: true)
    }
    
    func showAlert() {
        let alert = UIAlertController(title: Metrics.WrongUrlAlert.title,
                                      message: Metrics.WrongUrlAlert.message,
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: Metrics.WrongUrlAlert.buttonTitle, style: .cancel)
        alert.addAction(action)
        self.present(alert, animated: true)
    }
}
