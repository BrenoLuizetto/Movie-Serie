//
//  SearchViewModel.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 26/07/21.
//

import Foundation

class SearchViewModel: MovieViewModel {
    
    private var searchMovieData: [MovieViewData] = []
    private let service = MovieService()
    
    func getSearchMovies(query: String, callback: @escaping ([MovieViewData]?, Error?) -> Void) {
        
        let link = "\(Constants.Url.movieHeader)search/multi?" +
            "\(Constants.OPKeys.movieOPKey)&query=\(query)\(Constants.Url.language)"
        
        guard let url = URL(string: link) else {return}
        service.getMovie(url) { movie, erro  in
            if erro != nil {
                callback(nil, erro)
            }
            if let results = movie?.results {
                self.movieData = []
                for movies in results {
                    if movies.mediaType?.rawValue != "tv" {
                        self.movieData.append(MovieViewData(model: movies))
                    }
                }
            }
            callback(self.movieData, nil)
        }
    }
    
    func getPopularMovies(callback: @escaping ([MovieViewData]?, Error?) -> Void) {
        
        let link = "\(Constants.Url.movieHeader)movie/popular?" +
            "\(Constants.OPKeys.movieOPKey)\(Constants.Url.language)"
        
        guard let url = URL(string: link) else {return}
        service.getMovie(url) { movie, erro  in
            if erro != nil {
                callback(nil, erro)
            }
            if let results = movie?.results {
                self.movieData = []
                for movies in results {
                        self.movieData.append(MovieViewData(model: movies))
                }
            }
            callback(self.movieData, nil)
        }
    }}
