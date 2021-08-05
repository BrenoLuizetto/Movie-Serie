//
//  HomeConstants.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 28/06/21.
//

import Foundation

class HomeConstats {
    
    struct OPKeys {
        let movieOPKey = "5287ae8d76c11e98a09d2b4dfe0f443e"
    }
    
    struct url {
        static let imageOriginal = "https://image.tmdb.org/t/p/original"
    }

    struct movieType {
        static let upcoming = "movie/upcoming?"
        static let topWeek = "trending/all/week?"
        static let genres = "discover/movie?"
        static let genreList = "genre/movie/list?"
    }
    
    struct cellTitle {
        static let upcoming = "Próximos Lançamentos"
        static let topWeek = "Em Alta"
    }
    
    struct Fonts {
        static let kailassaBold = "Kailasa-Bold"
        static let avenirMedium = "Avenir-Medium"
        static let avenirHeavy = "Avenir-Heavy"
        static let avenirBook = "Avenir-Book"
    }
    
    struct cellIdentifier {
        static let movieCollection = "MovieCollectionCell"
    }
    
    struct labels {
        static let inComing = "Em breve"
        static let back = "Voltar"
    }
}
