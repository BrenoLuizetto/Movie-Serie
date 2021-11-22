//
//  HomeConstants.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 28/06/21.
//

import Foundation

class Constants {
    
    struct OPKeys {
        let movieOPKey = "api_key=5287ae8d76c11e98a09d2b4dfe0f443e"
    }
    
    struct Url {
        static let imageOriginal = "https://image.tmdb.org/t/p/original"
        static let movieHeader = "https://api.themoviedb.org/3/"
        static let language = "&language=pt-BR"
    }

    struct MovieType {
        static let upcoming = "movie/upcoming?"
        static let topWeek = "trending/all/week?"
        static let genres = "discover/movie?"
        static let genreList = "genre/movie/list?"
    }
    
    struct CellTitle {
        static let upcoming = "Próximos Lançamentos"
        static let topWeek = "Em Alta"
    }
    
    struct Fonts {
        static let kailassaBold = "Kailasa-Bold"
        static let avenirMedium = "Avenir-Medium"
        static let avenirHeavy = "Avenir-Heavy"
        static let avenirBook = "Avenir-Book"
    }
    
    struct CellIdentifier {
        static let movieCollection = "MovieCollectionCell"
    }
    
    struct Labels {
        static let inComing = "Em breve"
        static let back = "Voltar"
    }
    
    struct UserDefaults {
        static let favoriteMovies = "FavoriteMovies"
        static let rememberAccess = "RememberAccess"
        static let username = "username"
        static let pass = "pass"
        static let advertisingPreLogin = "advertisingPreLogin"
    }
}
