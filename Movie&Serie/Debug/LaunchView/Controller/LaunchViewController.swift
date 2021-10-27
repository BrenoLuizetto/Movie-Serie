//
//  LaunchScreenController.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 23/09/21.
//

import Foundation
import UIKit

final class LaunchViewController: BaseViewController {
    
    private let viewModel = LaunchViewModel()
    
    override func viewDidLoad() {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.view = LaunchView()
        verifyLogin()
    }

    func verifyLogin() {
        viewModel.validateLogin { doLogin in
            guard let doLogin = doLogin else { return }
            if doLogin {
                self.navigationController?.pushViewController(TabBarController(), animated: true)
            } else {
                if let advertising = try? UserDefaults.standard.getObject(forKey: MovieConstants.userDefaults.advertisingPreLogin,
                                                                          castTo: Bool.self), advertising {
                    self.navigationController?.pushViewController(LoginViewController(), animated: true)
                } else {
                    self.navigationController?.pushViewController(PreLoginViewController(), animated: true)
                }
            }
        }
    }
}
