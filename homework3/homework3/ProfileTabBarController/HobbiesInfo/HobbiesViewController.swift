//
//  HobbiesViewController.swift
//  homework3
//
//  Created by 1okmon on 26.04.2023.
//

import UIKit
import SnapKit

fileprivate enum ButtonMetrics {
    static let height = 70
    static let horizontalOffset  = 30
    static let verticalOffset  = 50
    static let titleColor = UIColor.black
    static let randomHobbyButtonTitle = "Показать случайное увлечение"
    static let allHobbiesButtonTitle = "Показать все увлечения"
    static var viewConfig: ViewConfig {
        ViewConfig(backgroundColor: UIColor.lightGray.withAlphaComponent(0.3),
                   cornerRadius: 15,
                   borderWidth: 2,
                   borderColor: UIColor.black)
    }
}

fileprivate enum LabelMetrics {
    static let defaultText = "Нажмите на любую кнопку"
    static let defaultTextColor = UIColor.gray
    static let normalTextColor = UIColor.black
    static let horizontalOffset = 30
    static let verticalOffset = 50
    static var viewConfig: ViewConfig {
        ViewConfig(backgroundColor: UIColor.white,
                   cornerRadius: 5,
                   borderWidth: 1,
                   borderColor: UIColor.gray)
    }
}

fileprivate enum AnimationTimeMetrics {
    static let withDuration: Double = 0.5
    static let delay: Double = 0
}

class HobbiesViewController: UIViewController, SelfViewConfigurator {
    private let hobbyInfoLabel = LabelWithInsets()
    private let chooseRandomHobbyButton = UIButton(type: .system)
    private let hobbyInfo = HobbiesInfo.myInfo()
    private let showAllHobbiesButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackgroundColor()
        addSubviews(to: view)
        configureSubviews()
    }
}

private extension HobbiesViewController {
    func addSubviews(to view: UIView) {
        view.addSubview(hobbyInfoLabel)
        view.addSubview(chooseRandomHobbyButton)
        view.addSubview(showAllHobbiesButton)
    }
    
    func configureConstraints(at label: LabelWithInsets) {
        label.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(LabelMetrics.verticalOffset)
            make.leading.trailing.equalToSuperview().inset(LabelMetrics.horizontalOffset)
        }
        label.applyHeightToPresentAllText()
    }
    
    func configureConstraints(at button: UIButton, upperView: UIView) {
        button.snp.makeConstraints { make in
            make.top.equalTo(upperView.snp.bottom).offset(LabelMetrics.verticalOffset)
            make.leading.trailing.equalToSuperview().inset(ButtonMetrics.horizontalOffset)
            make.height.equalTo(ButtonMetrics.height)
        }
    }
    
    func configureConstraints() {
        configureConstraints(at: hobbyInfoLabel)
        configureConstraints(at: chooseRandomHobbyButton, upperView: hobbyInfoLabel)
        configureConstraints(at: showAllHobbiesButton, upperView: chooseRandomHobbyButton)
    }
    
    func configureSubviews() {
        hobbyInfoLabel.font = Fonts.standard
        configure(view: hobbyInfoLabel, with: LabelMetrics.viewConfig)
        
        chooseRandomHobbyButton.titleLabel?.font = Fonts.standard
        configure(view: chooseRandomHobbyButton, with: ButtonMetrics.viewConfig)
        
        showAllHobbiesButton.titleLabel?.font = Fonts.standard
        configure(view: showAllHobbiesButton, with: ButtonMetrics.viewConfig)
        
        configureContents()
        configureConstraints()
        configureActions()
    }
    
    func configure(view: UIView, with config: ViewConfig) {
        view.backgroundColor = config.backgroundColor
        view.layer.cornerRadius = config.cornerRadius
        view.layer.borderWidth = config.borderWidth
        view.layer.borderColor = config.borderColor.cgColor
    }
    
    func configureContents() {
        configureContent(at: hobbyInfoLabel)
        configureContent(at: chooseRandomHobbyButton, with: ButtonMetrics.randomHobbyButtonTitle)
        configureContent(at: showAllHobbiesButton, with: ButtonMetrics.allHobbiesButtonTitle)
    }
    
    func configureContent(at label: UILabel) {
        label.text = LabelMetrics.defaultText
        label.textColor = LabelMetrics.defaultTextColor
    }
    
    func configureContent(at button: UIButton, with title: String) {
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(ButtonMetrics.titleColor, for: .normal)
        button.setTitle(title, for: .normal)
    }
    
    func configureActions() {
        chooseRandomHobbyButton.addTarget(self, action: #selector(showRandomHobby), for: .touchUpInside)
        showAllHobbiesButton.addTarget(self, action: #selector(showAllHobbies), for: .touchUpInside)
    }
    
    @objc func showRandomHobby(sender: UIButton!) {
        hobbyInfoLabel.text = hobbyInfo.randomHobbyDescription
        hobbyInfoLabel.textColor = LabelMetrics.normalTextColor
        animateChanges()
    }
    
    @objc func showAllHobbies(sender: UIButton!) {
        hobbyInfoLabel.text = hobbyInfo.allHobbiesDescription
        hobbyInfoLabel.textColor = LabelMetrics.normalTextColor
        animateChanges()
    }
    
    func animateChanges() {
        UIView.animate(withDuration: AnimationTimeMetrics.withDuration, delay: AnimationTimeMetrics.delay, options: .curveEaseOut) {
            self.hobbyInfoLabel.applyHeightToPresentAllText()
            self.view.layoutIfNeeded()
        }
    }
}
