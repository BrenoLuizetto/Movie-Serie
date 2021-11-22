//
//  DetailsData.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 08/07/21.
//

import Foundation

protocol DetailsViewDataType {
    var adult: Bool {get}
    var backdropPath: String {get}
    var belongsToCollection: String? {get}
    var budget: Int {get}
    var genres: [GenreDetails] {get}
    var homepage: String {get}
    var id: Int {get}
    var imdbID: String {get}
    var originalLanguage: String {get}
    var originalTitle: String {get}
    var overview: String {get}
    var popularity: Double {get}
    var posterPath: String {get}
    var productionCompanies: [ProductionCompany] {get}
    var productionCountries: [ProductionCountry] {get}
    var releaseDate: String {get}
    var revenue: Int {get}
    var runtime: Int {get}
    var spokenLanguages: [SpokenLanguage] {get}
    var status: String {get}
    var tagline: String {get}
    var title: String {get}
    var video: Bool {get}
    var voteAverage: Double {get}
    var voteCount: Int {get}
}

class DetailsViewData {
    
    private let model: MovieDetails
    
    init(model: MovieDetails) {
        self.model = model
    }
}

extension DetailsViewData: DetailsViewDataType {
    var adult: Bool {
        let aux = model.adult ?? false
        return aux
    }
    
    var backdropPath: String {
        let aux = model.backdropPath
        return aux
    }
    
    var belongsToCollection: String? {
        let aux = model.belongsToCollection
        return aux
    }
    
    var budget: Int {
        let aux = model.budget
        return aux
    }
    
    var genres: [GenreDetails] {
        let aux = model.genres
        return aux
    }
    
    var homepage: String {
        let aux = model.homepage
        return aux
    }
    
    var id: Int {
        let aux = model.id
        return aux
    }
    
    var imdbID: String {
        let aux = model.imdbID
        return aux
    }
    
    var originalLanguage: String {
        let aux = model.originalLanguage
        return aux
    }
    
    var originalTitle: String {
        let aux = model.originalTitle
        return aux
    }
    
    var overview: String {
        let aux = model.overview
        return aux
    }
    
    var popularity: Double {
        let aux = model.popularity
        return aux
    }
    
    var posterPath: String {
        let aux = model.posterPath
        return aux
    }
    
    var productionCompanies: [ProductionCompany] {
        let aux = model.productionCompanies
        return aux
    }
    
    var productionCountries: [ProductionCountry] {
        let aux = model.productionCountries
        return aux
    }
    
    var releaseDate: String {
        let aux = model.releaseDate
        return aux
    }
    
    var revenue: Int {
        let aux = model.revenue
        return aux
    }
    
    var runtime: Int {
        let aux = model.runtime
        return aux
    }
    
    var spokenLanguages: [SpokenLanguage] {
        let aux = model.spokenLanguages
        return aux
    }
    
    var status: String {
        let aux = model.status
        return aux
    }
    
    var tagline: String {
        let aux = model.tagline
        return aux
    }
    
    var title: String {
        let aux = model.title
        return aux
    }
    
    var video: Bool {
        let aux = model.video
        return aux
    }
    
    var voteAverage: Double {
        let aux = model.voteAverage
        return aux
    }
    
    var voteCount: Int {
        let aux = model.voteCount
        return aux
    }
        
}
