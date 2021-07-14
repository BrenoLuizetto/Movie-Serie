//
//  MovieType.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 02/07/21.
//

import Foundation

class MovieType: NSObject {
    let typeOfMovie: String
    let titleOfCell: String
    let genreType: String?
    
    init(typeMovie: String, titleOfCell: String, genreType: String?) {
        self.typeOfMovie = typeMovie
        self.titleOfCell = titleOfCell
        self.genreType = genreType
    }
}
