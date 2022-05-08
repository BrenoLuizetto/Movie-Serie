//
//  UserMenuViewModel.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 20/12/21.
//

import Foundation
import KeychainSwift

class UserMenuViewModel {
    
    private let client = UserMenuRequest()
    let userLogado = LoggedUser.shared.userLogado
    
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
