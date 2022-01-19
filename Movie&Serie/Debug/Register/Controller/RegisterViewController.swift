//
//  RegisterViewController.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 27/10/21.
//

import Foundation
import UIKit

final class RegisterViewController: BaseViewController {
    
    private let viewModel = RegisterViewModel()
    private var registerView: RegisterView?
    private var callback: (() -> Void)
    
    init(callback: @escaping (() -> Void)) {
        self.callback = callback
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.delegate = self
        self.registerView = RegisterView(viewModel: viewModel)
        self.view = registerView
        self.bindRegisterView()
        
    }
    
    private func bindRegisterView() {
        self.registerView?.close = {
            self.dismiss(animated: true, completion: nil)
        }
    }
}

extension RegisterViewController: RegisterDelegate {
    func pushTo(_ controller: UIViewController) {
        self.callback()
        self.dismiss(animated: true, completion: nil)
    }
    
}
