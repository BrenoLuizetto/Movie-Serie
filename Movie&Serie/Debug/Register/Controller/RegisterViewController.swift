//
//  RegisterViewController.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 27/10/21.
//

import Foundation
import UIKit

final class RegisterViewController: BaseViewController {
    
    private var registerView: RegisterView?
    private let viewModel = RegisterViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.delegate = self
        self.registerView = RegisterView(viewModel: viewModel)
        self.view = registerView
        
    }
    
    private func bindRegisterView() {
        self.registerView?.close = {
            self.navigationController?.popViewController(animated: true)
        }
    }
}

extension RegisterViewController: RegisterDelegate {
    func pushTo(_ controller: UIViewController) {
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}
