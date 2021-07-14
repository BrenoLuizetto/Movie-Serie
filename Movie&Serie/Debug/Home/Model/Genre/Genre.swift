//
//  Genre.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 02/07/21.
//

import Foundation

// MARK: - Genre
struct Genre: Codable {
    let genres: [GenreElement]
}

// MARK: - GenreElement
struct GenreElement: Codable {
    let id: Int
    let name: String
}
