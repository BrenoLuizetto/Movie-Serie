//
//  Itens.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 20/12/21.
//

import Foundation

struct ItensMenu: Codable {
    let result: [Itens]
    
    private enum CodingKeys: String, CodingKey {
        case result
    }
}

struct Itens: Codable {
    let name: String
    let icon: String
    let destinationKey: String
    
    private enum CodingKeys: String, CodingKey {
        case name
        case icon
        case destinationKey = "destination_key"
    }
}
