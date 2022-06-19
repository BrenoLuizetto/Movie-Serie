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
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.setListener()
    }
    override func viewWillDisappear(_ animated: Bool) {
        viewModel.removeListerner()
    }
    
    func showLogin() {
        self.loginView?.didTapLogin = { userName, pass in
            self.viewModel.doLogin(username: userName, pass: pass, { result in
//                self.view.showHUD()
                if result != nil {
                    self.view.removeHUD()
                    self.loginView?.buildWithError()
                } else {
                    self.pushTabBar()
                }
            })
        }
        
        self.loginView?.didTapRegister = {
            let registerVC = RegisterViewController {
                self.pushTabBar()
            }
            self.navigationController?.present(registerVC, animated: true)
            self.loginView?.removeHUD()
        }
        
        self.loginView?.didTapGoogleLogin = {
            self.view.showHUD()
            self.viewModel.googleLogin(controller: self, { error in
                self.view.removeHUD()
                if error == nil {
                    self.pushTabBar()
                }
            })
        }
    }
    
    func pushTabBar() {
        self.view.removeHUD()
        self.navigationController?.pushViewController(TabBarController(), animated: true)
    }
}
