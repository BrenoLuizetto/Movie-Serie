//
//  LoginViewModel.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 28/09/21.
//

import Foundation
import FirebaseAuth
import KeychainSwift

class LoginViewModel {
    
    private let userdefault = UserDefaults.standard
    private var rememberAcess = false
    private var auth: Auth?
    private var user: User?
    private var keychain = KeychainSwift()
    func rememberAccess() {
        try? userdefault.setObject(true, forKey: Constants.UserDefaults.rememberAccess)
        rememberAcess = true
    }
    
    func showLogin(username: String,
                   pass: String,
                   _ completion: @escaping ((Error?) -> Void)) {
        Auth.auth().addStateDidChangeListener { auth, user in
            self.auth = auth
            self.user = user
            self.doLogin(username: username,
                         pass: pass) { result in
                        completion(result)
            }
        }
    }
    
    func doLogin(username: String, pass: String, _ completion: @escaping ((Error?) -> Void)) {
            Auth.auth().signIn(withEmail: username, password: pass) { [weak self] authResult, error in
                guard let self = self else {return}
                if authResult != nil {
                    if self.rememberAcess {
                        self.keychain.set(username, forKey: Constants.UserDefaults.username,
                                          withAccess: KeychainSwiftAccessOptions.accessibleWhenUnlockedThisDeviceOnly)
                        self.keychain.set(pass, forKey: Constants.UserDefaults.pass,
                                          withAccess: KeychainSwiftAccessOptions.accessibleWhenUnlockedThisDeviceOnly)
                    }
                    completion(nil)
                } else {
                    completion(error)
                }
            }
    }
}
