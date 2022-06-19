//
//  User.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 26/12/21.
//

import Foundation
import FirebaseAuth
import Firebase

class LoggedUser {
    
    var userLogado: User?
    var profileImage: UIImage?
    private let userDefault = UserDefaults.standard
    
    static let shared = LoggedUser()
    
    func setUser(user: User?) {
        guard let user = user else { return }
        self.userLogado = user
    }
    
    func setImage(_ image: UIImage?) {
        self.profileImage = image
    }
    
    func clearUser() {
        self.userLogado = nil
        self.profileImage = nil
    }
}
