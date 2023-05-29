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
        static let closeActionTitleText = "Закрыть"
    }
}

final class ImagesLoadingView: UIView {
    private let urlTextField: UITextField
    private let addButton: UIButton
    private let tableView: UITableView
    init() {
        self.urlTextField = UITextField()
        self.addButton = UIButton(type: .system)
        self.tableView = UITableView()
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        addButton.addTarget(self, action: #selector(loadButtonTapped), for: .touchUpInside)
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
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ImageLoadingTableViewCell.className, for: indexPath) as? ImageLoadingTableViewCell else {
            return UITableViewCell()
        }
        return cell
    }
}
