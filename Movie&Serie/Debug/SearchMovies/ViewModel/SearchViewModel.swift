//
//  SearchViewModel.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 26/07/21.
//

import Foundation

class SearchViewModel: MovieViewModel {
    
    private var searchMovieData: Array<MovieViewData> = []
    private let service = SearchService()
    
    func getSearchMovies(query: String, callback: @escaping (Array<MovieViewData>?, Error?) -> Void) {
        service.getMovie(query: query) { movie, erro  in
            if erro != nil {
                callback(nil, erro)
            }
            if let results = movie?.results {
                self.movieData = []
                for movies in results{
                    if movies.mediaType != "tv" {
                        self.movieData.append(MovieViewData(model: movies))
                    }
                }
            }
            callback(self.movieData, nil)
        }
    }
}
