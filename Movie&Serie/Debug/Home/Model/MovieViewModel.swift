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

    func getMovie(type: MovieSettings, _ callback: @escaping ([MovieViewData]) -> Void) {
        
        let link = "\(Constants.Url.movieHeader)\(type.typeOfMovie)\(Constants.OPKeys.movieOPKey)" +
            "\(type.genreType ?? "")\(Constants.Url.language)"
        
        if type.typeOfMovie == Constants.MovieType.favoriteMovies,
            let favoriteData = getFavoriteMovies() {
            self.movieData = []
            self.movieData = favoriteData
            callback(self.movieData)
        } else {
            guard let url = URL(string: link) else {return}
            service.getMovie(url) { movie, error  in
                if let results = movie?.results {
                        self.movieData = []
                        for movies in results {
                            self.movieData.append(MovieViewData(model: movies,
                                                                movieType: type.typeOfMovie))
                        }
                    }
                    callback(self.movieData)
                }
        }
    }
    
    func parametersForCell(_ callback: @escaping ([MovieSettings]?) -> Void) {
        genreData = []
        var types: [MovieSettings] = [MovieSettings(typeMovie: Constants.MovieType.topWeek,
                                                    titleOfCell: Constants.CellTitle.topMovie,
                                                    genreType: nil),
                                      MovieSettings(typeMovie: Constants.MovieType.topWeek,
                                                    titleOfCell: Constants.CellTitle.topWeek,
                                                    genreType: nil)]
        
        if !(getFavoriteMovies()?.isEmpty ?? true) {
            types.insert(MovieSettings(typeMovie: Constants.MovieType.favoriteMovies,
                                       titleOfCell: Constants.CellTitle.myList,
                                       genreType: nil), at: 1)
        }
        
        getGenres { result in
            if result == 0 {
                callback(nil)
            }
            for genre in self.genreData {
                types.append(MovieSettings(typeMovie: Constants.MovieType.genres,
                                       titleOfCell: genre.name ,
                                       genreType: String("&with_genres=\(genre.id)")))
            }
            callback(types)
        }
       
    }
    
    private func getGenres(_ callback: @escaping (Int) -> Void) {
       let link = "\(Constants.Url.movieHeader)\(Constants.MovieType.genreList)" +
                    "\(Constants.OPKeys.movieOPKey)\(Constants.Url.language)"
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
    
    private func getFavoriteMovies() -> [MovieViewData]? {
        let us = UserDefaults.standard
        do {
            let movieArray =  try? us.getObject(forKey: Constants.UserDefaults.favoriteMovies,
                                               castTo: [MovieViewData].self)
            return movieArray
        } catch {
            return nil
        }
    }
}
