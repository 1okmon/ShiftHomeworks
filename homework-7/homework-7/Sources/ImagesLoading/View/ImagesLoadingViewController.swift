//
//  ViewController.swift
//  homework7
//
//  Created by 1okmon on 26.05.2023.
//

import UIKit

private enum Metrics {
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
        self.view.backgroundColor = .white
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
    }
}
