//
//  RegisterView.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 27/10/21.
//

import Foundation
import UIKit

final class RegisterView: UIView {
    
    var close: (() -> Void)?
    
    private lazy var container: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: Constants.Images.closeButton), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = Constants.Labels.insertData
        lbl.font = UIFont(name: Constants.Fonts.avenirHeavy, size: 30)
        lbl.textColor = .white
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = Constants.Labels.createAccount
        lbl.font = UIFont(name: Constants.Fonts.avenirMedium, size: 20)
        lbl.textColor = .white
        return lbl
    }()
    
    private lazy var emailField: InputView = {
        let field = InputView()
        field.backgroundColor = .clear
        field.setInputType(.user)
        return field
    }()
    
    private lazy var passField: InputView = {
        let field = InputView()
        field.backgroundColor = .clear
        field.setInputType(.pass)
        return field
    }()
    
    private lazy var confirmPassField: InputView = {
        let field = InputView()
        field.backgroundColor = .clear
        field.setInputType(.confirmPass)
        return field
    }()
    
    private lazy var registerButton: UIButton = {
        let button = UIButton()
         button.backgroundColor = .white
         button.setTitle("Continuar", for: .normal)
         button.setTitleColor(.black, for: .normal)
         button.addTarget(self, action: #selector(doRegister), for: .touchUpInside)
         button.layer.cornerRadius = 5
         button.layer.borderWidth = 1
         button.setButtonState(isEnabled: false)
         return button
    }()
    
    private var hasEmail = false
    private var hasPass = false
    private var hasConfirmPass = false
    
    private var viewModel: RegisterViewModel?
    
    init(viewModel: RegisterViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        self.buildItens()
        self.validateFields()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func doRegister() {
        self.showHUD()

        self.viewModel?.registerUser(emailField.getInputValue(),
                                     pass: passField.getInputValue(), completion: {
            
            self.removeHUD()
        })
    }
    
    @objc
    private func closeAction() {
        close?()
    }
    
    private func validateFields() {
        emailField.callback = { result in
            self.hasEmail = result
            self.enableButton()
        }
        
        passField.callback = { result in
            self.hasPass = result
            self.enableButton()
        }
        
        confirmPassField.callback = { result in
            if self.confirmPassField.getInputValue() == self.passField.getInputValue() {
                self.hasConfirmPass = result
                self.enableButton()
            }
        }
    }
    
    private func enableButton() {
        if hasEmail, hasPass, hasConfirmPass {
            registerButton.setButtonState(isEnabled: true)
        } else {
            registerButton.setButtonState(isEnabled: false)
        }
    }
    
}

extension RegisterView: BuildViewConfiguration {
    func buildViewHierarchy() {
        self.addSubview(container)
        container.addSubview(closeButton)
        container.addSubview(titleLabel)
        container.addSubview(subtitleLabel)
        container.addSubview(emailField)
        container.addSubview(passField)
        container.addSubview(confirmPassField)
        container.addSubview(registerButton)
    }
    
    func makeConstraints() {
        container.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(32)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-16)
        }
        
        closeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.left.equalTo(self)
            make.height.equalTo(40)
        }
        titleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(closeButton.snp.bottom).offset(16)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
        }
        
        emailField.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(subtitleLabel.snp.bottom).offset(16)
            make.height.equalTo(60)
        }
        
        passField.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(emailField.snp.bottom).offset(16)
            make.height.equalTo(60)
        }
        
        confirmPassField.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(passField.snp.bottom).offset(16)
            make.height.equalTo(60)
        }
        
        registerButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(confirmPassField.snp.bottom).offset(16)
            make.height.equalTo(50)
        }
    }
    
    func configElements() {
        
    }
    
}
