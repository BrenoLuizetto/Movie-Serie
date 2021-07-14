//
//  GenreViewData.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 02/07/21.
//

import Foundation

protocol GenreViewDataType {
    var id: Int {get}
    var name: String {get}
}

class GenreViewData {
    
    private let model: GenreElement
    
    init(model: GenreElement) {
        self.model = model
    }
}

extension GenreViewData: GenreViewDataType {
    var id: Int {
        let aux = model.id
        return aux
    }
    
    var name: String {
        let aux = model.name
        return aux
    }

}
