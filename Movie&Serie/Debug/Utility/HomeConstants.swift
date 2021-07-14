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

    struct movieType {
        let upcoming = "movie/upcoming?"
        let topWeek = "trending/all/week?"
        let genres = "discover/movie?"
        let genreList = "genre/movie/list?"
    }
    
    struct cellTitle {
        let upcoming = "Próximos Lançamentos"
        let topWeek = "Em Alta"
    }
}
