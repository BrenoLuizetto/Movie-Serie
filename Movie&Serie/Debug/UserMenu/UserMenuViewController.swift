//
//  UserMenuViewController.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 20/12/21.
//

import Foundation
import UIKit

protocol UserMenuDelegate: AnyObject {
    func logout()
}

class UserMenuViewController: BaseViewController {
    
    private var userMenuView: UserMenuView?
    private let viewModel = UserMenuViewModel()
    
    override func viewDidLoad() {
        userMenuView = UserMenuView(viewModel: viewModel,
                                    delegate: self)
        self.view = userMenuView
        self.configNavBar()

    }
    
}

extension UserMenuViewController: UserMenuDelegate {
    func logout() {
        self.viewModel.doLogout()
        let loginVC = UINavigationController(rootViewController: LaunchViewController())
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(loginVC)
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
}
