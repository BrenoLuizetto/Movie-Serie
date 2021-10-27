//
//  RegisterViewController.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 22/10/21.
//

import Foundation
import UIKit

class PreLoginViewController: BaseViewController {
    
    private var contentView = PreLoginView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = contentView
        bindContentView()
        saveUserDefault()
    }
    
    private func saveUserDefault() {
        try? UserDefaults.standard.setObject(true, forKey: MovieConstants.userDefaults.advertisingPreLogin)
    }
    
    private func bindContentView() {
        contentView.didTapStart = {
            self.navigationController?.pushViewController(LoginViewController(), animated: true)
        }
    }
}
