//
//  LoginViewController.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 22/09/21.
//

import Foundation
import UIKit
import FirebaseAuth

class LoginViewController: BaseViewController {
    
    private var loginView: LoginView?
    private var viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        loginView = LoginView(viewModel: viewModel)
        showLogin()
        self.view = self.loginView
    }
    
    func showLogin() {
        self.loginView?.didTapLogin = { userName, pass in
            self.viewModel.ShowLogin(username: userName, pass: pass, { result in
                self.view.showHUD()
                if result != nil {
                    self.loginView?.buildWithError()
                } else {
                    self.view.removeHUD()
                    self.navigationController?.pushViewController(TabBarController(), animated: true)
                }
            })
        }
        
        self.loginView?.didTapRegister = {
            self.navigationController?.pushViewController(RegisterViewController(), animated: true)
        }
    }    
}
