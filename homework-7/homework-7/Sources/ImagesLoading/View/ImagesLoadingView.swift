//
//  View.swift
//  homework7
//
//  Created by 1okmon on 26.05.2023.
//

import UIKit
import SnapKit

private enum Metrics {
    enum TextField {
        static let trailingInset = 16
        static let height = 60
        static let placeholder = "Вставьте ссылку на изображение"
        static let leftViewFrame = CGRect(x: 0, y: 0, width: 15, height: 0)
        static let borderColor = UIColor.black.cgColor
        static let cornerRadius: CGFloat = 10
        static let borderWidth: CGFloat = 1
        static let defaultText = "https://loremflickr.com/640/360"
    }
    
    enum Button {
        static let topOffset = 40
        static let width = 120
        static let height = 60
        static let borderColor = UIColor.black.cgColor
        static let borderWidth: CGFloat = 1
        static let cornerRadius: CGFloat = 10
        static let titleColor = UIColor.black
        static let titleText = "Загрузить"
    }
    
    enum TableView {
        static let topOffset = 40
        static let cellHeight: CGFloat = 170
    }
    
    enum Alert {
        static let deleteActionTitleText = "Удалить"
        static let saveActionTitleText = "Сохранить"
        static let closeActionTitleText = "Закрыть"
    }
}

final class ImagesLoadingView: UIView {
    var tableViewCellAlertHandler: (([UIAlertAction], LoadingState?) -> Void)?
    var loadButtonTapHandler: ((UUID, String) -> Void)?
    var pauseTapHandler: ((UUID) -> Void)?
    var deleteTapHandler: ((UUID) -> Void)?
    var saveTapHandler: ((UUID) -> Void)?
    private let urlTextField: UITextField
    private let addButton: UIButton
    private let tableView: UITableView
    private var imageIds: [UUID]
    private var cellsState: [UUID: LoadingState]
    
    init() {
        self.urlTextField = UITextField()
        self.addButton = UIButton(type: .system)
        self.tableView = UITableView()
        self.imageIds = [UUID]()
        self.cellsState = [UUID: LoadingState]()
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(to newImagesState: [UUID: LoadingState]) {
        DispatchQueue.main.async {
            for (imageId, state) in newImagesState {
                self.updateCell(with: imageId, to: state)
            }
        }
    }
    
    func delete(at imageId: UUID) {
        let indexPath = self.indexPath(by: imageId)
        self.cellsState[imageId] = nil
        self.imageIds.removeAll { $0 == imageId }
        self.tableView.deleteRows(at: [indexPath], with: .automatic)
    }
}

// MARK: items configurations extension
private extension ImagesLoadingView {
    func configure() {
        configureUrlTextField()
        configureAddButton()
        configureTableView()
    }
    
    func configureUrlTextField() {
        self.addSubview(urlTextField)
        urlTextField.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(Metrics.TextField.trailingInset)
            make.height.equalTo(Metrics.TextField.height)
        }
        urlTextField.placeholder = Metrics.TextField.placeholder
        let leftView = UIView()
        leftView.frame = Metrics.TextField.leftViewFrame
        urlTextField.leftViewMode = .always
        urlTextField.leftView = leftView
        urlTextField.layer.borderColor = Metrics.TextField.borderColor
        urlTextField.layer.cornerRadius = Metrics.TextField.cornerRadius
        urlTextField.layer.borderWidth = Metrics.TextField.borderWidth
        urlTextField.text = Metrics.TextField.defaultText
    }
    
    func configureAddButton() {
        self.addSubview(addButton)
        addButton.snp.makeConstraints { make in
            make.top.equalTo(urlTextField.snp.bottom).offset(Metrics.Button.topOffset)
            make.centerX.equalToSuperview()
            make.width.equalTo(Metrics.Button.width)
            make.height.equalTo(Metrics.Button.height)
        }
        addButton.layer.borderColor = Metrics.Button.borderColor
        addButton.layer.borderWidth = Metrics.Button.borderWidth
        addButton.layer.cornerRadius = Metrics.Button.cornerRadius
        addButton.setTitleColor(Metrics.Button.titleColor, for: .normal)
        addButton.setTitle(Metrics.Button.titleText, for: .normal)
        addButton.addTarget(self, action: #selector(loadButtonTapped(_:)), for: .touchUpInside)
    }
    
    func configureTableView() {
        self.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(addButton.snp.bottom).offset(Metrics.TableView.topOffset)
            make.leading.trailing.bottom.equalToSuperview()
        }
        tableView.register(ImageLoadingTableViewCell.self, forCellReuseIdentifier: ImageLoadingTableViewCell.className)
        tableView.delegate = self
        tableView.dataSource = self
    }
}

// MARK: methods extension
private extension ImagesLoadingView {
    @objc func loadButtonTapped(_ sender: UIButton) {
        load()
    }
    
    func indexPath(by imageId: UUID) -> IndexPath {
        return IndexPath(row: imageIds.firstIndex(of: imageId) ?? 0, section: 0)
    }
    
    func load() {
        loadButtonTapHandler?(UUID(), urlTextField.text ?? "")
    }
    
    func createNewCell(with imageId: UUID) {
        self.imageIds.append(imageId)
        self.cellsState.updateValue(.loading(progress: 0), forKey: imageId)
        self.tableView.insertRows(at: [indexPath(by: imageId)], with: .automatic)
    }
    
    func showAlert(_ imageId: UUID) {
        var alertActions: [UIAlertAction] = []
        let delete = UIAlertAction(title: Metrics.Alert.deleteActionTitleText, style: .destructive) { [weak self] _ in
            guard let index = self?.imageIds.firstIndex(of: imageId) else { return }
            self?.cellsState.removeValue(forKey: imageId)
            self?.imageIds.remove(at: index)
            self?.tableView.reloadData()
            self?.deleteTapHandler?(imageId)
        }
        alertActions.append(delete)
        if case .loaded = cellsState[imageId] {
            let save = UIAlertAction(title: Metrics.Alert.saveActionTitleText, style: .default) { [weak self] _ in
                self?.saveTapHandler?(imageId)
            }
            alertActions.append(save)
        }
        let close = UIAlertAction(title: Metrics.Alert.closeActionTitleText, style: .cancel)
        alertActions.append(close)
        tableViewCellAlertHandler?(alertActions, cellsState[imageId])
    }
    
    func updateCell(with imageId: UUID, to newState: LoadingState?) {
        if self.cellsState[imageId] == nil {
            createNewCell(with: imageId)
        }
        guard let newState = newState else {
            self.delete(at: imageId)
            return
        }
        guard let prevState = self.cellsState[imageId] else { return }
        self.cellsState.updateValue(newState, forKey: imageId)
        if prevState != newState {
            if case .loading(let progress) = newState {
                guard case .loading = prevState else {
                    self.tableView.reloadRows(at: [self.indexPath(by: imageId)], with: .none)
                    return
                }
                guard let cell = self.tableView.cellForRow(at: self.indexPath(by: imageId)) as? ImageLoadingTableViewCell else {
                    return }
                cell.setProgress(progress)
                return
            }
            self.tableView.reloadRows(at: [self.indexPath(by: imageId)], with: .none)
        }
    }
}

// MARK: delegate extension
extension ImagesLoadingView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Metrics.TableView.cellHeight
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        Metrics.TableView.cellHeight
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        imageIds.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let state = cellsState[imageIds[indexPath.row]] else { return }
        switch state {
        case .loading, .paused:
            pauseTapHandler?(imageIds[indexPath.row])
        case .error, .loaded:
            let imageId = imageIds[indexPath.row]
            showAlert(imageId)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ImageLoadingTableViewCell.className, for: indexPath) as? ImageLoadingTableViewCell else {
            return UITableViewCell()
        }
        guard let cellState = cellsState[imageIds[indexPath.row]] else {
            return cell
        }
        cell.state = cellState
        return cell
    }
}
