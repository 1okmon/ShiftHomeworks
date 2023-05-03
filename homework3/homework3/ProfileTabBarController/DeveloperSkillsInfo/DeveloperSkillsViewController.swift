//
//  DeveloperSkillsViewController.swift
//  homework3
//
//  Created by 1okmon on 26.04.2023.
//

import UIKit
import SnapKit

fileprivate enum LabelMetrics {
    static let horizontalOffset = 20
    static let verticalOffset = 15
    static let viewConfig = ViewConfig(backgroundColor: UIColor.white,
                                       cornerRadius: 5,
                                       borderWidth: 1,
                                       borderColor: UIColor.gray)
}

final class DeveloperSkillsViewController: UIViewController, SelfViewConfigurator {
    private let devSkillsInfo = DevSkillsInfo.myInfo()
    private var experienceAgeLabel = LabelWithInsets()
    private var programmingLanguagesLabel = LabelWithInsets()
    private var expectationsLabel = LabelWithInsets()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appendLabels(to: view)
        configureLabels()
        configureBackgroundColor()
    }
}

private extension DeveloperSkillsViewController {
    func appendLabels(to view: UIView) {
        view.addSubview(experienceAgeLabel)
        view.addSubview(programmingLanguagesLabel)
        view.addSubview(expectationsLabel)
    }
    
    func configureLabelsConstraints() {
        self.experienceAgeLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(LabelMetrics.verticalOffset)
            make.leading.trailing.equalToSuperview().inset(LabelMetrics.horizontalOffset)
        }
        experienceAgeLabel.applyHeightToPresentAllText()
        
        self.programmingLanguagesLabel.snp.makeConstraints { make in
            make.top.equalTo(experienceAgeLabel.snp.bottom).offset(LabelMetrics.verticalOffset)
            make.leading.trailing.equalToSuperview().inset(LabelMetrics.horizontalOffset)
        }
        programmingLanguagesLabel.applyHeightToPresentAllText()

        expectationsLabel.snp.makeConstraints { make in
            make.top.equalTo(programmingLanguagesLabel.snp.bottom).offset(LabelMetrics.verticalOffset)
            make.leading.trailing.equalToSuperview().inset(LabelMetrics.horizontalOffset)
        }
        expectationsLabel.applyHeightToPresentAllText()
    }
    
    func configureLabels() {
        configure(label: experienceAgeLabel)
        configure(label: programmingLanguagesLabel)
        configure(label: expectationsLabel)
        configureLabelsContent()
        configureLabelsConstraints()
    }
    
    func configure(label: UILabel) {
        label.font = Fonts.standard
        label.backgroundColor = LabelMetrics.viewConfig.backgroundColor
        label.layer.cornerRadius = LabelMetrics.viewConfig.cornerRadius
        label.layer.borderWidth = LabelMetrics.viewConfig.borderWidth
        label.layer.borderColor = LabelMetrics.viewConfig.borderColor.cgColor
    }
    
    func configureLabelsContent() {
        experienceAgeLabel.text = devSkillsInfo.experienceAgeDescription
        programmingLanguagesLabel.text = devSkillsInfo.programmingLanguagesDescription
        expectationsLabel.text = devSkillsInfo.expectationsDescription
    }
}
