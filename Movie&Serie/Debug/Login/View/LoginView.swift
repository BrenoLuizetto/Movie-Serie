//
//  LoginView.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 05/09/21.
//

import Foundation
import UIKit

enum InputType {
    case user
    case pass
    case confirmPass
}

class LoginView: UIView {
    
    var didTapLogin: ((String, String) -> Void)?
    var didTapRegister: (() -> Void)?
    
    private lazy var container: UIView = {
       let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    private lazy var header: UILabel = {
        let lbl = UILabel()
        lbl.text = "BRCine"
        lbl.font = UIFont(name: Constants.Fonts.kailassaBold, size: 40)
        lbl.textColor = .white
        return lbl
    }()
    
    private lazy var userView: InputView = {
        let view = InputView()
        view.backgroundColor = .clear
        view.setInputType(.user)
        return view
    }()
    
    private lazy var passView: InputView = {
        let view = InputView()
        view.backgroundColor = .clear
        view.setInputType(.pass)
        return view
    }()
    
    private lazy var rememberMessage: UILabel = {
        let lbl = UILabel()
        lbl.text = "Lembrar acesso"
        lbl.font = UIFont(name: Constants.Fonts.kailassaBold, size: 12)
        lbl.textColor = .white
        return lbl
    }()
    
    private lazy var rememberCheck: UISwitch = {
        let view = UISwitch()
        view.isOn = false
        view.preferredStyle = .sliding
        view.addTarget(self, action: #selector(rememberAcess), for: .allTouchEvents)
        return view
    }()
    
    private lazy var continueButton: UIButton = {
       let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Entrar", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(doLogin), for: .touchUpInside)
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.setButtonState(isEnabled: false)
        return button
    }()
    
    private lazy var registerLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Não possui conta? Cadastre-se"
        lbl.font = UIFont(name: Constants.Fonts.kailassaBold, size: 12)
        lbl.textColor = .white
        lbl.textAlignment = .center
        let tap = UITapGestureRecognizer(target: self, action: #selector(register))
        lbl.isUserInteractionEnabled = true
        lbl.addGestureRecognizer(tap)
        return lbl
    }()
    
    private lazy var warningView: WarningView = {
        let view = WarningView()
        return view
    }()
    
    private var userHasText = false
    private var passHasText = false
    private var hasError = false
    
    var viewModel: LoginViewModel?
        
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        self.buildItens()
        validateFields()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func validateFields() {
        userView.callback = { result in
            self.userHasText = result
            self.enableButton()
        }
        
        passView.callback = { result in
            self.passHasText = result
            self.enableButton()
        }
    }
    
    private func enableButton() {
        if userHasText, passHasText {
            continueButton.setButtonState(isEnabled: true)
        } else {
            continueButton.setButtonState(isEnabled: false)
        }
    }
    
    func buildWithError() {
        self.hasError = true
        self.removeAllViews()
        self.buildItens()
        self.warningView.callback = {
            self.buildWithouError()
        }
    }
    
    func buildWithouError() {
        self.hasError = false
        self.removeAllViews()
        self.buildItens()
    }
    
    @objc
    func doLogin() {
        showHUD()
        didTapLogin?(userView.getInputValue(), passView.getInputValue())
    }
    
    @objc
    func rememberAcess() {
        viewModel?.rememberAccess()
    }
    
    @objc
    private func register() {
        self.showHUD()
        didTapRegister?()
    }
}

extension LoginView: BuildViewConfiguration {
    func buildViewHierarchy() {
        self.addSubview(container)
        if hasError {
            self.addSubview(warningView)
        }
        self.addSubview(header)
        self.addSubview(userView)
        self.addSubview(passView)
        self.addSubview(rememberMessage)
        self.addSubview(rememberCheck)
        self.addSubview(continueButton)
        self.addSubview(registerLabel)
    }
    
    func makeConstraints() {
        container.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        if hasError {
            warningView.snp.makeConstraints { make in
                make.top.equalTo(container.snp.top).offset(50)
                make.left.equalToSuperview().offset(15)
                make.right.equalToSuperview().offset(-15)
            }
        }
        
        header.snp.makeConstraints { make in
            if hasError {
                make.top.equalTo(warningView.snp.bottom).offset(30)
            } else {
                make.top.equalToSuperview().offset(50)
            }
            make.centerX.equalToSuperview()
        }
    
        userView.snp.makeConstraints { make in
            make.top.equalTo(header.snp.bottom).offset(20)
            make.left.equalTo(container.snp.left).offset(15)
            make.right.equalTo(container.snp.right).offset(-15)
            make.height.equalTo(70)
        }
        
        passView.snp.makeConstraints { make in
            make.top.equalTo(userView.snp.bottom).offset(20)
            make.left.equalTo(container.snp.left).offset(15)
            make.right.equalTo(container.snp.right).offset(-15)
            make.height.equalTo(70)
        }
        
        rememberCheck.snp.makeConstraints { make in
            make.left.equalTo(container.snp.left).offset(15)
            make.top.equalTo(passView.snp.bottom).offset(15)
        }
        
        rememberMessage.snp.makeConstraints { make in
            make.left.equalTo(rememberCheck.snp.right).offset(15)
            make.centerY.equalTo(rememberCheck.snp.centerY)
        }
        
        registerLabel.snp.makeConstraints { make in
            make.left.equalTo(container.snp.left).offset(15)
            make.right.equalTo(container.snp.right).offset(-15)
            make.top.equalTo(continueButton.snp.bottom).offset(10)
        }
        
        continueButton.snp.makeConstraints { make in
            make.top.equalTo(rememberCheck.snp.bottom).offset(50)
            make.left.equalTo(container.snp.left).offset(15)
            make.right.equalTo(container.snp.right).offset(-15)
            make.height.equalTo(50)
        }
    }
    
    func configElements() {
        
    }
}
