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
    private var genreData: [GenreViewData] = []

    open var movieData: [MovieViewData] = []
    var tableView = HomeTableView()

    func getMovie(type: MovieType, _ callback: @escaping ([MovieViewData]) -> Void) {
        
        let link = "\(Constants.Url.movieHeader)\(type.typeOfMovie)\(Constants.OPKeys().movieOPKey)" +
            "\(type.genreType ?? "")\(Constants.Url.language)"
        
        guard let url = URL(string: link) else {return}
        service.getMovie(url) { movie, error  in
            if let results = movie?.results {
                    self.movieData = []
                    for movies in results {
                            self.movieData.append(MovieViewData(model: movies))
                    }
                }
                callback(self.movieData)
            }
    }
    
    func parametersForCell(_ callback: @escaping ([MovieType]?) -> Void) {
        var types: [MovieType] = [MovieType(typeMovie: Constants.MovieType.topWeek,
                                            titleOfCell: Constants.CellTitle.topWeek,
                                            genreType: nil)]
        
        getGenres { result in
            if result == 0 {
                callback(nil)
            }
            for genre in self.genreData {
                types.append(MovieType(typeMovie: Constants.MovieType.genres,
                                       titleOfCell: genre.name ,
                                       genreType: String("&with_genres=\(genre.id)")))
            }
            callback(types)
        }
       
    }
    
    private func getGenres(_ callback: @escaping (Int) -> Void) {
       let link = "\(Constants.Url.movieHeader)\(Constants.MovieType.genreList)" +
                    "\(Constants.OPKeys().movieOPKey)\(Constants.Url.language)"
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
