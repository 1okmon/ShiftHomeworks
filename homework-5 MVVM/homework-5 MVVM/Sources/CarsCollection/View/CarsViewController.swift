//
//  CarsViewController.swift
//  CollectionApp
//
//  Created by 1okmon on 04.05.2023.
//

import UIKit

private enum Metrics {
    static let viewTitle = "Cars list"
    static let viewBackgroundColor = UIColor.white
}

final class CarsViewController: UIViewController, IObserver {
    var id: UUID
    private var viewModel: ICarsViewModel
    private let carsView: CarsView
    private var configureLayout: (() -> Void)?
    
    init(viewModel: ICarsViewModel) {
        self.id = UUID()
        self.viewModel = viewModel
        self.carsView = CarsView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        guard let configureLayout = self.configureLayout else { return }
        configureLayout()
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    func update<T>(with value: T) {
        guard let cars = value as? [CarModel] else { return }
        self.carsView.updateContent(with: cars)
    }
}

private extension CarsViewController {
    func configure() {
        self.title = Metrics.viewTitle
        self.view.backgroundColor = Metrics.viewBackgroundColor
        self.configureCarsView()
    }
    
    func configureCarsView() {
        self.view.addSubview(self.carsView)
        self.carsView.cellTapHandler = { [weak self] carId in
            self?.viewModel.goToCarDetails(with: carId)
        }
        self.configureCarsViewConstraints()
        self.configureLayout = { [weak self] in
            self?.carsView.updateLayout()
        }
    }
    
    func configureCarsViewConstraints() {
        self.carsView.snp.makeConstraints { make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide.snp.edges)
        }
    }
}
