//
//  UserMenuRequest.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 20/12/21.
//

import Foundation

class UserMenuRequest: BaseRequest {
    
    typealias CompletionUserMenu = (RequestResult<ItensMenu>) -> Void
    
    func getItens(completion: @escaping CompletionUserMenu) {
        request(filename: "menu_itens", completion: completion)
    }
    
}
