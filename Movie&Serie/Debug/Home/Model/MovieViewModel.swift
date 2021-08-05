//
//  HomeViewModel.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 29/06/21.
//

import Foundation

class MovieViewModel {
    
    private var movieModel: Movie?
    private var service =  HomeService()
    private var genreData: Array<GenreViewData> = []

    open var movieData: Array<MovieViewData> = []
    var tableView = HomeTableView()

    func getMovie(type: MovieType, _ callback: @escaping (Array<MovieViewData>) -> Void) {
            
            service.getMovie(type: type.typeOfMovie, genres: type.genreType ?? "") { movie in
                if let results = movie.results {
                    self.movieData = []
                    for movies in results{
                            self.movieData.append(MovieViewData(model: movies))
                    }
                }
                callback(self.movieData)
            }
    }
    
    func parametersForCell(_ callback: @escaping ([MovieType]?) -> Void) {
        var types: [MovieType] = [MovieType(typeMovie: HomeConstats.movieType.topWeek,
                                            titleOfCell: HomeConstats.cellTitle.topWeek,
                                            genreType: nil)]
        
        getGenres { result in
            if result == 0 {
                callback(nil)
            }
            for genre in self.genreData {
                types.append(MovieType(typeMovie: HomeConstats.movieType.genres, titleOfCell: genre.name , genreType: String("&with_genres=\(genre.id)")))
            }
            callback(types)
        }
       
    }
    
    private func getGenres(_ callback: @escaping (Int) -> Void) {
        service.getGenres(type: HomeConstats.movieType.genreList, genres: "") { result in
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
