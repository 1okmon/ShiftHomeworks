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
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet var profileInfoLabels: [UILabel]!
    private let profileInfo = ProfileInfo.myInfo()
    
    private func configure(labels: [UILabel]) {
        for label in labels {
            switch label.tag {
            case 0:
                label.text = profileInfo.fullNameDescription
            case 1:
                label.text = profileInfo.dateOfBirthDescription
            case 2:
                label.text = profileInfo.cityOfBirthDescription
            case 3:
                label.text = profileInfo.cityOfResidenceDescription
            default:
                label.text = String()
            }
        }
    }
    
    private func configure(imageView: UIImageView, with image: UIImage?) {
        imageView.layer.cornerRadius = ProfileImage.cornerRadius
        imageView.image = image
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure(imageView: profileImageView, with: profileInfo.image)
        configure(labels: profileInfoLabels)
    }
}
