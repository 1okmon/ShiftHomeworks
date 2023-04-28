//
//  MainInfoViewController.swift
//  homework3
//
//  Created by 1okmon on 26.04.2023.
//

import UIKit

fileprivate enum ProfileImage {
    static let cornerRadius: CGFloat = 30
}

class MainInfoViewController: UIViewController {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet var profileInfoLabels: [UILabel]!
    private let profileInfo = ProfileInfo.getAlexProfileInfo()
    
    private func configureLables() {
        for label in profileInfoLabels {
            switch label.tag {
            case 0:
                label.text = profileInfo.getFullName()
            case 1:
                label.text = profileInfo.getDateOfBirth()
            case 2:
                label.text = profileInfo.getCityOfBirth()
            case 3:
                label.text = profileInfo.getCityOfResidence()
            default:
                label.text = String()
            }
        }
    }
    
    private func configureProfileImage() {
        profileImage.layer.cornerRadius = ProfileImage.cornerRadius
        profileImage.image = profileInfo.image
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureProfileImage()
        configureLables()
    }
}
