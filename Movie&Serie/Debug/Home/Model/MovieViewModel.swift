//
//  HomeViewModel.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 29/06/21.
//

import Foundation

class MovieViewModel {
    
    private var movieModel: Movie?
    private var service =  MovieService()
    private var genreData: Array<GenreViewData> = []

    open var movieData: Array<MovieViewData> = []
    var tableView = HomeTableView()

    func getMovie(type: MovieType, _ callback: @escaping (Array<MovieViewData>) -> Void) {
        
        let link = "\(MovieConstants.url.movieHeader)\(type.typeOfMovie)\(MovieConstants.OPKeys().movieOPKey)" +
            "\(type.genreType ?? "")\(MovieConstants.url.language)"
        
        guard let url = URL(string: link) else {return}
        service.getMovie(url) { movie, error  in
            if let results = movie?.results {
                    self.movieData = []
                    for movies in results{
                            self.movieData.append(MovieViewData(model: movies))
                    }
                }
                callback(self.movieData)
            }
    }
    
    func parametersForCell(_ callback: @escaping ([MovieType]?) -> Void) {
        var types: [MovieType] = [MovieType(typeMovie: MovieConstants.movieType.topWeek,
                                            titleOfCell: MovieConstants.cellTitle.topWeek,
                                            genreType: nil)]
        
        getGenres { result in
            if result == 0 {
                callback(nil)
            }
            for genre in self.genreData {
                types.append(MovieType(typeMovie: MovieConstants.movieType.genres, titleOfCell: genre.name , genreType: String("&with_genres=\(genre.id)")))
            }
            callback(types)
        }
       
    }
    
    private func getGenres(_ callback: @escaping (Int) -> Void) {
       let link = "\(MovieConstants.url.movieHeader)\(MovieConstants.movieType.genreList)" +
                    "\(MovieConstants.OPKeys().movieOPKey)\(MovieConstants.url.language)"
        guard let url = URL(string: link) else {return}
        service.getGenres(url) { result in
            guard let genreResult = result?.genres else {
                callback(0)
                return
            }
                for genre in genreResult {
                    self.genreData.append(GenreViewData(model: genre))
                }
            callback(1)
        }
    }
}
