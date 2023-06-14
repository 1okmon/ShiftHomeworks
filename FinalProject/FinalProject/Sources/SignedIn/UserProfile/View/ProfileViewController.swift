//
//  ProfileViewController.swift
//  FinalProject
//
//  Created by 1okmon on 24.05.2023.
//

import UIKit

private enum Metrics {
    static let backgroundColor = Theme.backgroundColor
    
    enum ImagePickerAlert {
        static let title = "Загрузить фото"
        static let photoLibraryTitle = "Из галереи"
        static let cameraTitle = "С помощью камеры"
        static let cancel = "Отменить"
    }
}

final class ProfileViewController: KeyboardSupportedViewController {
    private var profileView: ProfileView
    private var presenter: IProfilePresenter?
    private var imagePicker: UIImagePickerController
    
    init() {
        self.imagePicker = UIImagePickerController()
        self.profileView = ProfileView()
        super.init(keyboardSupportedView: self.profileView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        presenter?.fetchRemoteData()
    }
    
    func setPresenter(_ presenter: IProfilePresenter) {
        self.presenter = presenter
    }
    
    func update(with userData: UserData) {
        self.profileView.update(with: userData)
    }
    
    func update(with image: UIImage?) {
        self.profileView.update(with: image)
    }
}

private extension ProfileViewController {
    func configure() {
        self.view.backgroundColor = Metrics.backgroundColor
        self.imagePicker.delegate = self
        configureProfileView()
    }
    
    func configureProfileView() {
        self.view.addSubview(self.profileView)
        self.profileView.snp.makeConstraints { make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide.snp.edges)
        }
        configureProfileViewHandlers()
    }
    
    func configureProfileViewHandlers() {
        self.profileView.saveTapHandler = { [weak self] userData in
            self?.presenter?.save(userData: userData)
        }
        self.profileView.signOutTapHandler = { [weak self] in
            self?.presenter?.signOut()
        }
        self.profileView.profileImageTapped = { [weak self] in
            self?.showImagePicker()
        }
    }
    
    func showImagePicker() {
        let alert = AlertBuilder()
            .setTitle(Metrics.ImagePickerAlert.title)
            .setAlertStyle(.actionSheet)
            .addAction(UIAlertAction(title: Metrics.ImagePickerAlert.photoLibraryTitle,
                                     style: .default,
                                     handler: { [weak self] _ in
                self?.imagePicker.sourceType = .photoLibrary
                self?.imagePicker.allowsEditing = true
                guard let imagePicker = self?.imagePicker else { return }
                self?.present(imagePicker, animated: true, completion: nil)
            }))
            .addAction(UIAlertAction(title: Metrics.ImagePickerAlert.cameraTitle,
                                     style: .default,
                                     handler: { [weak self] _ in
                self?.imagePicker.sourceType = .camera
                self?.imagePicker.allowsEditing = true
                guard let imagePicker = self?.imagePicker else { return }
                self?.present(imagePicker, animated: true, completion: nil)
            }))
            .addAction(UIAlertAction(title: Metrics.ImagePickerAlert.cancel, style: .cancel))
            .build()
        self.present(alert, animated: true, completion: nil)
    }
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.update(with: pickedImage)
        }
        self.dismiss(animated: true, completion: nil)
    }
}
