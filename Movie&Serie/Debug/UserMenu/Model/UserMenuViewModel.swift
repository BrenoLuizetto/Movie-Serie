//
//  UserMenuViewModel.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 20/12/21.
//

import Foundation
import KeychainSwift
import FirebaseAuth
import GoogleSignIn

class UserMenuViewModel {
    
    private let client = UserMenuRequest()
    let userShared = LoggedUser.shared
    
    func getMenuItens(callback: @escaping (ItensMenu) -> Void) {
        client.getItens { result in
            switch result {
            case .success(let menu):
                callback(menu)
            case .error:
                break
            }
        }
    }
    
    func doLogout() {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
        GIDSignIn.sharedInstance.signOut()
        KeychainSwift().delete(Constants.UserDefaults.username)
        KeychainSwift().delete(Constants.UserDefaults.pass)
        LoggedUser.shared.clearUser()
    }
    
    func setProfilePicture(_ image: UIImage?) {
        LoggedUser.shared.setImage(image)
    }
    
    func getProfilePicture() -> UIImage? {
        return LoggedUser.shared.profileImage ?? nil
    }
}
