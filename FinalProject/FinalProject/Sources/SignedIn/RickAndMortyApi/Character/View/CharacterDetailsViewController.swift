//
//  CharacterDetailsViewController.swift
//  FinalProject
//
//  Created by 1okmon on 31.05.2023.
//

import UIKit

final class CharacterDetailsViewController: UIViewController, IObserver {
    var id: UUID
    private let viewModel: CharacterDetailsViewModel
    private let characterDetailsView: CharacterDetailsView
    
    init(viewModel: CharacterDetailsViewModel) {
        self.id = UUID()
        self.viewModel = viewModel
        self.characterDetailsView = CharacterDetailsView()
        super.init(nibName: nil, bundle: nil)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update<T>(with value: T) {
        guard let character = value as? CharacterDetails else { return }
        self.characterDetailsView.update(with: character)
    }
}

private extension CharacterDetailsViewController {
    func configure() {
        self.view.addSubview(self.characterDetailsView)
        self.characterDetailsView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
