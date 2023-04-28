//
//  HobbiesViewController.swift
//  homework3
//
//  Created by 1okmon on 26.04.2023.
//

import UIKit
import SnapKit

fileprivate enum Button {
    static let height = 70
    static let horizontalOffset  = 30
    static let verticalOffset  = 50
    static let titleColor = UIColor.black
    static let randomHoobieButton = "Показать случайное увлечение"
    static let allHobbiesButton = "Показать все увлечения"
    static var viewConfig: ViewConfig {
        ViewConfig(backgroundColor: UIColor.lightGray.withAlphaComponent(0.3),
                   cornerRadius: 15,
                   borderWidth: 2,
                   borderColor: UIColor.black)
    }
}

fileprivate enum Label {
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

fileprivate enum Animations {
    static let withDuration: Double = 0.5
    static let delay: Double = 0
}

class HobbiesViewController: UIViewController, DefaultMainViewPresentation {
    private let hobbieLabelInfo = LabelWithInsets()
    private let chooseRandomHoobieButton = UIButton(type: .system)
    private let hobbieInfo = HobbiesInfo.getAlexProfileInfo()
    private let showAllHobbiesButton = UIButton(type: .system)
    
    private func addSubviewsToView() {
        view.addSubview(hobbieLabelInfo)
        view.addSubview(chooseRandomHoobieButton)
        view.addSubview(showAllHobbiesButton)
    }
    
    private func createLabelConstrains() {
        hobbieLabelInfo.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(Label.verticalOffset)
            make.leading.trailing.equalToSuperview().inset(Label.horizontalOffset)
        }
        hobbieLabelInfo.applyHeightToPresentAllText()
    }
    
    private func createButtonsConstrains() {
        chooseRandomHoobieButton.snp.makeConstraints { make in
            make.top.equalTo(hobbieLabelInfo.snp.bottom).offset(Label.verticalOffset)
            make.leading.trailing.equalToSuperview().inset(Button.horizontalOffset)
            make.height.equalTo(Button.height)
        }
        
        showAllHobbiesButton.snp.makeConstraints { make in
            make.top.equalTo(chooseRandomHoobieButton.snp.bottom).offset(Button.verticalOffset)
            make.leading.trailing.equalToSuperview().inset(Button.horizontalOffset)
            make.height.equalTo(Button.height)
        }
    }
    
    private func createConstraints() {
        createLabelConstrains()
        createButtonsConstrains()
    }
    
    private func configureViewsView() {
        hobbieLabelInfo.font = Fonts.standartFont
        configureViewView(view: hobbieLabelInfo, with: Label.viewConfig)
        
        chooseRandomHoobieButton.titleLabel?.font = Fonts.standartFont
        configureViewView(view: chooseRandomHoobieButton, with: Button.viewConfig)
        
        showAllHobbiesButton.titleLabel?.font = Fonts.standartFont
        configureViewView(view: showAllHobbiesButton, with: Button.viewConfig)
    }
    
    private func configureViewView(view: UIView, with config: ViewConfig) {
        view.backgroundColor = config.backgroundColor
        view.layer.cornerRadius = config.cornerRadius
        view.layer.borderWidth = config.borderWidth
        view.layer.borderColor = config.borderColor.cgColor
    }
    
    private func configureViewContent() {
        hobbieLabelInfo.text = Label.defaultText
        hobbieLabelInfo.textColor = Label.defaultTextColor
        configureViewContent(at: chooseRandomHoobieButton, with: Button.randomHoobieButton)
        configureViewContent(at: showAllHobbiesButton, with: Button.allHobbiesButton)
    }
    
    private func configureViewContent(at button: UIButton, with title: String) {
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(Button.titleColor, for: .normal)
        button.setTitle(title, for: .normal)
    }
    
    private func setActionsToButtons() {
        chooseRandomHoobieButton.addTarget(self, action: #selector(showRandomHoobie), for: .touchUpInside)
        showAllHobbiesButton.addTarget(self, action: #selector(showAllHoobies), for: .touchUpInside)
    }
    
    @objc private func showRandomHoobie(sender: UIButton!) {
        hobbieLabelInfo.text = hobbieInfo.getRandomHobbieAsText()
        hobbieLabelInfo.textColor = Label.normalTextColor
        animateChanges()
    }
    
    @objc private func showAllHoobies(sender: UIButton!) {
        hobbieLabelInfo.text = hobbieInfo.getAllHobbiesAsText()
        hobbieLabelInfo.textColor = Label.normalTextColor
        animateChanges()
    }
    
    private func animateChanges() {
        UIView.animate(withDuration: Animations.withDuration, delay: Animations.delay, options: .curveEaseOut) {
            self.hobbieLabelInfo.applyHeightToPresentAllText()
            self.view.layoutIfNeeded()
        }
    }
    
//    private func configureMainViewPresentation() {
//        self.view.backgroundColor = .white
//    }
//    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMainViewPresentation()
        addSubviewsToView()
        configureViewsView()
        configureViewContent()
        createConstraints()
        setActionsToButtons()
    }
}

