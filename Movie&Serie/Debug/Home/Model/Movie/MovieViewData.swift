//
//  MovieData.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 29/06/21.
//

import Foundation

protocol MovieViewDataType {
    var posterPath: String {get}
    var adult: Bool {get}
    var overview: String {get}
    var releaseDate: String {get}
    var genreIDS: [Int] {get}
    var id: Int {get}
    var originalTitle: String {get}
    var originalLanguage: String {get}
    var title: String {get}
    var backdropPath: String? {get}
    var popularity: Double {get}
    var voteCount: Int {get}
    var video: Bool {get}
    var voteAverage: Double {get}
    var mediaType: String? {get}
}

class MovieViewData {
    
    private let model: Result
    
    init(model: Result) {
        self.model = model
    }
}

extension MovieViewData: MovieViewDataType {
    var posterPath: String {
        let aux = model.posterPath ?? ""
        return aux
    }
    
    var adult: Bool {
        guard let aux = model.adult else {return false}
        return aux
    }
    
    var overview: String {
        let aux = model.overview
        return aux
    }
    
    var releaseDate: String {
        guard let aux = model.releaseDate else {return ""}
        return aux
    }
    
    var genreIDS: [Int] {
        let aux = model.genreIDS
        return aux
    }
    
    var id: Int {
        let aux = model.id
        return aux
    }
    
    var originalTitle: String {
        guard let aux = model.originalTitle else {return ""}
        return aux
    }
    
    var originalLanguage: String {
        let aux = model.originalLanguage
        return aux
    }
    
    var title: String {
        if let aux = model.title, aux.isEmpty {
            return aux
        }
        return model.originalTitle ?? ""
    }
    
    var backdropPath: String? {
        if let aux = model.backdropPath {
            return aux
        }
        return model.posterPath
    }
    
    var popularity: Double {
        let aux = model.popularity
        return aux
    }
    
    var voteCount: Int {
        let aux = model.voteCount
        return aux
    }
    
    var video: Bool {
        guard let aux = model.video else {return false}
        return aux
    }
    
    var voteAverage: Double {
        let aux = model.voteAverage
        return aux
    }
    
    var mediaType: String? {
        let aux = model.mediaType
        return aux
    }
    
}
