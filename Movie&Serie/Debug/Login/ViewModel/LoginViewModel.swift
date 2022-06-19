//
//  LoginViewModel.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 28/09/21.
//

import Foundation
import FirebaseAuth
import KeychainSwift
import FirebaseCore
import GoogleSignIn
import UIKit

class LoginViewModel {
    
    private let userdefault = UserDefaults.standard
    private var rememberAcess = false
    private var listener: AuthStateDidChangeListenerHandle?
    private var keychain = KeychainSwift()
    func rememberAccess() {
        try? userdefault.setObject(true, forKey: Constants.UserDefaults.rememberAccess)
        rememberAcess = true
    }
    
    func doLogin(username: String, pass: String, _ completion: @escaping ((Error?) -> Void)) {
        Auth.auth().signIn(withEmail: username, password: pass) { [weak self] authResult, error in
            guard let self = self else {return}
            self.checkAuthResult(with: authResult,
                                 username: username,
                                 pass: pass,
                                 error: error) { authError in
                completion(authError)
            }
            
        }
    }
    
    func googleLogin(controller: UIViewController,
                     _ completion: @escaping ((Error?) -> Void)) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        
        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(with: config,
                                        presenting: controller) { [unowned self] user, error in
            if let error = error {
                completion(error)
            }
            
            guard let authentication = user?.authentication,
                  let idToken = authentication.idToken else { return }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: authentication.accessToken)
            Auth.auth().signIn(with: credential) { authResult, error in
                self.checkAuthResult(with: authResult,
                                     username: "",
                                     pass: "",
                                     error: error) { authError in
                    completion(authError)
                }
            }
        }
    }
    
    func checkAuthResult(with authResult: AuthDataResult?,
                         username: String,
                         pass: String,
                         error: Error?,
                         completion: @escaping ((Error?) -> Void)) {
        if authResult != nil {
            LoggedUser.shared.setUser(user: authResult?.user)
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
