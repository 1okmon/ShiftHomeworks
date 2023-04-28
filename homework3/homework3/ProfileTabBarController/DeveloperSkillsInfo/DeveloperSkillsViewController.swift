//
//  DeveloperSkillsViewController.swift
//  homework3
//
//  Created by 1okmon on 26.04.2023.
//

import UIKit
import SnapKit

fileprivate enum Label {
    static let horizontalOffset = 20
    static let verticalOffset = 15
    static let viewConfig = ViewConfig(backgroundColor: UIColor.white,
                                       cornerRadius: 5,
                                       borderWidth: 1,
                                       borderColor: UIColor.gray)
}

final class DeveloperSkillsViewController: UIViewController, DefaultMainViewPresentation {
    private let devSkillsInfo = DevSkillsInfo.getAlexProfileInfo()
    private var experienceAgeLabel = LabelWithInsets()
    private var programmingLanguagesLabel = LabelWithInsets()
    private var expectationsLabel = LabelWithInsets()
    
    private func addLabelsToMainView() {
        view.addSubview(experienceAgeLabel)
        view.addSubview(programmingLanguagesLabel)
        view.addSubview(expectationsLabel)
    }
    
    private func configureLabelsConstraints() {
        self.experienceAgeLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(Label.verticalOffset)
            make.leading.trailing.equalToSuperview().inset(Label.horizontalOffset)
        }
        experienceAgeLabel.applyHeightToPresentAllText()
        
        self.programmingLanguagesLabel.snp.makeConstraints { make in
            make.top.equalTo(experienceAgeLabel.snp.bottom).offset(Label.verticalOffset)
            make.leading.trailing.equalToSuperview().inset(Label.horizontalOffset)
        }
        programmingLanguagesLabel.applyHeightToPresentAllText()

        expectationsLabel.snp.makeConstraints { make in
            make.top.equalTo(programmingLanguagesLabel.snp.bottom).offset(Label.verticalOffset)
            make.leading.trailing.equalToSuperview().inset(Label.horizontalOffset)
        }
        expectationsLabel.applyHeightToPresentAllText()
    }
    
    private func configureLabelsView() {
        configureLabelView(label: experienceAgeLabel)
        configureLabelView(label: programmingLanguagesLabel)
        configureLabelView(label: expectationsLabel)
    }
    
    private func configureLabelView(label: UILabel) {
        label.font = Fonts.standartFont
        label.backgroundColor = Label.viewConfig.backgroundColor
        label.layer.cornerRadius = Label.viewConfig.cornerRadius
        label.layer.borderWidth = Label.viewConfig.borderWidth
        label.layer.borderColor = Label.viewConfig.borderColor.cgColor
    }
    
    private func configureLabelsContent() {
        experienceAgeLabel.text = devSkillsInfo.getExperienceAgeDescription()
        programmingLanguagesLabel.text = devSkillsInfo.getProgrammingLanguagesDescription()
        expectationsLabel.text = devSkillsInfo.getExpectationsDescription()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addLabelsToMainView()
        configureLabelsView()
        configureLabelsContent()
        configureLabelsConstraints()
        configureMainViewPresentation()
    }
}
