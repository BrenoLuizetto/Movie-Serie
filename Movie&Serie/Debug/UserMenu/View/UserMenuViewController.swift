//
//  UserMenuViewController.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 20/12/21.
//

import Foundation
import UIKit
import FirebaseAuth

protocol UserMenuDelegate: AnyObject {
    func logout()
    func aboutUs()
    func showCamera()
}

class UserMenuViewController: BaseViewController {
    
    private var userMenuView: UserMenuView?
    private let viewModel = UserMenuViewModel()
    
    override func viewDidLoad() {
        userMenuView = UserMenuView(viewModel: viewModel,
                                    delegate: self)
        self.view = userMenuView
        self.view.showHUD()
        self.configNavBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.view.removeHUD()
    }
    
}

extension UserMenuViewController: UserMenuDelegate {
    func aboutUs() {
        self.navigationController?.pushViewController(AboutUsViewController(), animated: true)
    }
    
    func logout() {
        self.viewModel.doLogout()
        let loginVC = UINavigationController(rootViewController: LaunchViewController())
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(loginVC)
    }
    
    func showCamera() {
        showAlert()
    }

}

extension UserMenuViewController {
    private func configNavBar() {
        self.navigationController?.isNavigationBarHidden = false
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: Constants.Labels.back,
                                                                style: .plain,
                                                                target: self, action: #selector(backAction(sender:)))
        
    }
    
    @objc func backAction(sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    func showAlert() {
        let alert = UIAlertController(title: nil,
                                      message: nil,
                                      preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: Constants.Labels.removePicture,
                                      style: .destructive,
                                      handler: { (_) in
            self.userMenuView?.setDefaultImage()
            self.viewModel.setProfilePicture(nil)
            
        }))
        alert.addAction(UIAlertAction(title: Constants.Labels.takePicture,
                                      style: .default,
                                      handler: { (_) in
            self.initCamera()
        }))
        
        alert.addAction(UIAlertAction(title: Constants.Labels.choosePicture,
                                      style: .default,
                                      handler: { (_) in
            self.initLibrary()
        }))
        
        if let picture = viewModel.getProfilePicture() {
            alert.addAction(UIAlertAction(title: Constants.Labels.showPicture,
                                          style: .default,
                                          handler: { (_) in
                self.showPicture(picture)
            }))
        }
    
        
        alert.addAction(UIAlertAction(title: Constants.Labels.cancel,
                                      style: .cancel,
                                      handler: nil))
        
        self.navigationController?.present(alert, animated: true, completion: nil)
    }
    
    private func initCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = .camera
            self.present(imagePickerController, animated: true, completion: nil)
        }
    }
    
    private func initLibrary() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }
    }
    
    private func showPicture(_ picture: UIImage) {
            let vc = ProfilePhotoViewController(profilePicture: picture)
            self.navigationController?.present(vc,
                                               animated: true,
                                               completion: nil)
    }
}

extension UserMenuViewController: UINavigationControllerDelegate,
                                  UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        
        self.userMenuView?.setImage(image)
        self.viewModel.setProfilePicture(image)
        self.dismiss(animated: true, completion: nil)
    }
}
