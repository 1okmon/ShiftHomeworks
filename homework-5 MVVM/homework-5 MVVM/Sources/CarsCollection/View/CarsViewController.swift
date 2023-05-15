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

final class CarsViewController: UIViewController {
    private var viewModel: ICarsViewModel
    
    init(viewModel: ICarsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private var configureLayout: (()->Void) = {}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        configureLayout()
        super.viewWillTransition(to: size, with: coordinator)
    }
}

private extension CarsViewController {
    func configure() {
        let carsView = CarsView(carsViewModel: viewModel)
        title = Metrics.viewTitle
        configure(view: view)
        configure(carsView: carsView)
    }
    
    func configure(carsView: CarsView) {
        view.addSubview(carsView)
        configureConstraints(at: carsView)
        configureLayout = {
            carsView.updateLayout()
        }
    }
    
    func configureConstraints(at carsView: CarsView) {
        carsView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }
    }
    
    func configure(view: UIView) {
        view.backgroundColor = Metrics.viewBackgroundColor
    }
}
