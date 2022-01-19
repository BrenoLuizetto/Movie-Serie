//
//  RegisterViewModel.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 27/10/21.
//

import Foundation
import FirebaseAuth

final class RegisterViewModel {
    
    weak var delegate: RegisterDelegate?
    
    func registerUser(_ mail: String,
                      pass: String,
                      completion: @escaping () -> Void) {
        Auth.auth().createUser(withEmail: mail,
                               password: pass) { result, error in
            if let erro = error {
                print(erro)
                completion()
            } else {
                LoggedUser.shared.setUser(user: result?.user)
                self.delegate?.pushTo(TabBarController())
                completion()
            }
        }
    }
}
