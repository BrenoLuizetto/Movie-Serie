//
//  InputView.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 22/09/21.
//

import Foundation
import UIKit
import SnapKit

class InputView: UIView {
    private lazy var inputTextField: UITextField = {
        let field = UITextField()
        field.backgroundColor = .clear
        field.textColor = .white
        field.isUserInteractionEnabled = true
        field.delegate = self
        return field
    }()
    
    private lazy var inputSeparator: UIView = {
       let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    private lazy var errorLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "insira um email válido."
        lbl.font = UIFont(name: MovieConstants.Fonts.avenirBook, size: 12)
        lbl.textColor = .red
        return lbl
    }()
    
    private var type: inputType = .user
    private var hasError = false
    
    var callback: ((_ isInput: Bool) -> Void)?
    
    func setInputType(_ type: inputType) {
        buildItens()
        self.type = type
        switch type {
        case .user:
            self.inputTextField.attributedPlaceholder = NSAttributedString(string: "Email",
                                                                            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
            self.inputTextField.keyboardType = .emailAddress
            self.inputTextField.textContentType = .emailAddress
        case .pass:
            self.inputTextField.attributedPlaceholder = NSAttributedString(string: "Senha",
                                                                            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
            self.inputTextField.textContentType = .password
            self.inputTextField.isSecureTextEntry = true
        
        case .confirmPass:
            self.inputTextField.attributedPlaceholder = NSAttributedString(string: "Confirmar senha",
                                                                            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
            self.inputTextField.textContentType = .password
            self.inputTextField.isSecureTextEntry = true

        }
    }
    
    func getInputValue() -> String {
        return inputTextField.text ?? ""
    }
}

extension InputView: BuildViewConfiguration {
    func buildViewHierarchy() {
        self.addSubview(inputTextField)
        self.addSubview(inputSeparator)
        if hasError {
            self.addSubview(errorLabel)
        }
    }
    
    func makeConstraints() {
        inputTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        inputSeparator.snp.makeConstraints { make in
            make.top.equalTo(inputTextField.snp.bottom).offset(10)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(1)
        }
        
        if hasError {
            errorLabel.snp.makeConstraints { make in
                make.top.equalTo(inputSeparator.snp.bottom).offset(5)
                make.left.bottom.equalToSuperview()
            }
        }
    }
    
    func configElements() {
        //not implemented
    }
    
    
}

extension InputView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.inputSeparator.backgroundColor = .white
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if self.type == .user {
            let charSet = CharacterSet(["@","."])
            if textField.text?.rangeOfCharacter(from: charSet) != nil {
                self.hasError = false
                self.removeAllViews()
                self.inputSeparator.backgroundColor = .green
                self.buildItens()
            } else {
                self.hasError = true
                self.inputSeparator.backgroundColor = .red
                self.buildItens()
            }
        }
        self.inputSeparator.backgroundColor = .gray
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if inputTextField.hasText {
            callback?(true)
        } else {
            callback?(false)
        }
    }
}
