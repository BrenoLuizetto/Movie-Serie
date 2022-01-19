//
//  User.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 26/12/21.
//

import Foundation
import FirebaseAuth

class LoggedUser {
    
    var userLogado: User?
    static let shared = LoggedUser()
    
    func setUser(user: User?) {
        guard let user = user else { return }
        self.userLogado = user
    }
    
    func clearUser() {
        self.userLogado = nil
    }
}
