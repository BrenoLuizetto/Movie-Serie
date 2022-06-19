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
    private var listener: AuthStateDidChangeListenerHandle?
    
    func validateLogin(_ completion: @escaping ((Bool?) -> Void)) {
        guard let access = try? userdefault.getObject(forKey: Constants.UserDefaults.rememberAccess,
                                                      castTo: Bool.self)
        else {
            completion(false)
            return
        }
        if access {
            guard let username = keychain.get(Constants.UserDefaults.username),
                  let pass = keychain.get(Constants.UserDefaults.pass)
            else {
                completion(false)
                return
            }
            
                    Auth.auth().signIn(withEmail: username, password: pass) { authResult, error in
                        if authResult != nil {
                            LoggedUser.shared.setUser(user: authResult?.user)
                            completion(true)
                        } else {
                            completion(false)
                        }
                    }
        } else {
            completion(false)
        }
    }
    
    func setListener() {
        listener = Auth.auth().addStateDidChangeListener { _, _ in
            // Not implemented
        }
    }
    
    func removeListerner() {
        guard let listener = listener else {
            return
        }

        Auth.auth().removeStateDidChangeListener(listener)
    }
}
