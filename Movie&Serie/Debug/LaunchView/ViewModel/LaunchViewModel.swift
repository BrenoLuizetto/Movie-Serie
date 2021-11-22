//
//  PreLoginViewModel.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 28/09/21.
//

import Foundation
import FirebaseAuth
import KeychainSwift

class LaunchViewModel {
    
    private let userdefault = UserDefaults.standard
    private let keychain = KeychainSwift()
    
    func validateLogin(_ completion: @escaping ((Bool?) -> Void)) {
        guard let access = try? userdefault.getObject(forKey: Constants.UserDefaults.rememberAccess,
                                                      castTo: Bool.self)
        else { completion(false)
            return
        }
        if access {
            guard let username = keychain.get(Constants.UserDefaults.username),
                  let pass = keychain.get(Constants.UserDefaults.pass)
            else { completion(false)
                return
            }
            
            Auth.auth().addStateDidChangeListener { auth, user in
                if user != nil {
                    Auth.auth().signIn(withEmail: username, password: pass) { authResult, error in
                        if authResult != nil {
                            completion(true)
                        } else {
                            completion(false)
                        }
                    }
                }
            }
        } else {
            completion(false)
        }
    }
}
