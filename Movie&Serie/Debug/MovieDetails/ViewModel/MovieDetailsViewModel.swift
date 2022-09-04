//
//  MovieDetailsViewModel.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 06/07/21.
//

import Foundation
import UIKit

class DetailsCell<T> {
    var reuseIdentifier: String
    var cellType: AnyClass
    var data: T
    
    init(reuseIdentifier: String,
         cellType: AnyClass,
         data: T) {
        self.reuseIdentifier = reuseIdentifier
        self.cellType = cellType
        self.data = data
    }
}

class MovieDetailsViewModel: MovieViewModel {
    
    let movie: MovieViewData
    var movieDetails: MovieDetails?
    weak var delegate: MovieCollectionProtocol?
    private let service = MovieService()
    var cellData: [DetailsCell<Any>] = []
    let routerProvider: RouterProvider
    
    var refreshView: ((DetailsCell<Any>?) -> Void)?
    var showHUD: (() -> Void)?
    var hideHUD: (() -> Void)?
    
    init(_ movie: MovieViewData,
         routerProvider: RouterProvider,
         delegate: MovieCollectionProtocol?) {
        self.movie = movie
        self.routerProvider = routerProvider
        self.delegate = delegate
        super.init()
    }
    
    func getMovieBackground() -> URL? {
        guard let backgroundPath = self.movie.backdropPath,
              let url = URL(string: "\(Constants.Url.imageOriginal)\(backgroundPath)") else { return nil }
        return url
    }
    
    func getMoviePoster(callback: @escaping (URL) -> Void) {
        let posterPath = self.movie.posterPath
        if let imageUrl = URL(string: "\(Constants.Url.imageOriginal)\(posterPath)") {
            callback(imageUrl)
        }
    }
    
    func getTrailer(callback: @escaping (MovieTrailer) -> Void) {
        guard let url = URL(string: "\(Constants.Url.movieHeader)\(movie.mediaType.rawValue)/\(movie.id)" + "/videos?\(Constants.OPKeys.movieOPKey)\(Constants.Url.language)") else {return}
        
        service.getMovie(url) { (result: MovieTrailer?, error) in
            if let result = result {
                callback(result)
            }
        }
    }
    
    func getRecommendationMovies(_ callback: @escaping ([MovieViewData]) -> Void) {
        let id = String(movie.id)
        var recommendationMovieData: [MovieViewData] = []
        guard let url = URL(string: "\(Constants.Url.movieHeader)\(movie.mediaType.rawValue)/" +
                            "\(id)/recommendations?\(Constants.OPKeys.movieOPKey)" +
                            "\(Constants.Url.language)") else {return}
        service.getMovie(url) { (recommendation: Movie?, error) in
            if let recommendationList = recommendation?.results {
                recommendationMovieData = []
                for movies in recommendationList {
                    recommendationMovieData.append(MovieViewData(model: movies))
                }
                
            }
            callback(recommendationMovieData)
        }
    }
    
    func getDetailsMovie(_ callback: @escaping () -> Void) {
        if movieDetails == nil {
            guard let url = URL(string: "\(Constants.Url.movieHeader)\(movie.mediaType)/" +
                                "\(movie.id)?\(Constants.OPKeys.movieOPKey)\(Constants.Url.language)") else { return }
            service.getMovie(url) { (MovieDetails: MovieDetails?, error) in
                if MovieDetails != nil {
                    self.movieDetails = MovieDetails
                }
                callback()
            }
        } else {
            callback()
        }
    }
    
    func openMovieStream(controller: UIViewController) {
        if let url = URL(string: self.movieDetails?.homepage ?? "") {
            UIApplication.shared.open(url)
        } else {
            let alert = UIAlertController(title: Constants.Labels.errorTitle,
                                          message: Constants.Labels.errorText,
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .destructive, handler: nil))
            routerProvider.goTo(route: "alert",
                                from: controller,
                                with: ["alert": alert],
                                completion: nil,
                                callback: nil)
        }
    }
    
    func addFavorite() {
        let us = UserDefaults.standard
        do {
            do {
                var movieArray = try us.getObject(forKey: Constants.UserDefaults.favoriteMovies,
                                                  castTo: [MovieViewData].self)
                if !validateUserDefault(movieArray: movieArray) {
                    movieArray.append(self.movie)
                    try us.setObject(movieArray, forKey: Constants.UserDefaults.favoriteMovies)
                    return
                } else {
                    movieArray.removeAll(where: {$0.id == movie.id})
                    try? us.setObject(movieArray, forKey: Constants.UserDefaults.favoriteMovies)
                    return
                }
            } catch {
                let movieArray = [self.movie]
                try us.setObject(movieArray, forKey: Constants.UserDefaults.favoriteMovies)
                return
            }
        } catch {
            print(error.localizedDescription)
            return
        }
    }
    
    private func validateUserDefault(movieArray: [MovieViewData]) -> Bool {
        let hasMovie = movieArray.contains(where: {
             $0.id == movie.id
        })
        
        return hasMovie
    }
    
    func validateFavoriteList() -> Bool {
        let us = UserDefaults.standard
        do {
            let movieArray =  try us.getObject(forKey: Constants.UserDefaults.favoriteMovies,
                                               castTo: [MovieViewData].self)

            if validateUserDefault(movieArray: movieArray) {
                return true
            } else {
                return false
            }
        } catch {
            return false
        }
    }
    
    func DidListChange() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "updateFavoriteMovies"),
                                        object: nil)
    }
    
}

extension MovieDetailsViewModel {
    
    func setDataSource(infoContainerProtocol: InfoContainerProtocol) {
        getTrailerCell()
        cellData.append(getInfoCell(infoContainerProtocol: infoContainerProtocol))
        getRecommedationCell()
    }
    
    private func getInfoCell(infoContainerProtocol: InfoContainerProtocol) -> DetailsCell<Any> {
        let movieRating = Int(movie.voteAverage * 10)
        let rating = movieRating == 0 ? Constants.Labels.inComing : String("\(movieRating)% relevante")
        
        let data = InfoCellData(title: movie.title,
                                rating: rating,
                                release: movie.releaseDate.getYear(),
                                description: movie.overview,
                                isFavorite: validateFavoriteList(),
                                delegate: infoContainerProtocol)
        
        return DetailsCell(reuseIdentifier: "\(InfoContainerViewCell.self)",
                               cellType: InfoContainerViewCell.self,
                               data: data)
    }
    
    private func getTrailerCell() {
        getTrailer { trailer in
            var data = TrailerViewData()
            if let results = trailer.results.first {
                data.key = results.key
            } else {
                data.url = self.getMovieBackground()
            }
            
            let cell: DetailsCell<Any> = DetailsCell(reuseIdentifier: "\(TrailerViewCell.self)",
                                   cellType: TrailerViewCell.self,
                                   data: data)
            if data.key != nil || data.url != nil {
                self.cellData.insert(cell, at: 0)
                self.refreshView?(cell)
            }
        }
    }
    
    private func getRecommedationCell() {
        getRecommendationMovies { recommendationMovies in
            if !recommendationMovies.isEmpty {
                let data = RecommendatioViewData(movies: recommendationMovies,
                                                     collectionProtocol: self.delegate)
                let cell: DetailsCell<Any> = DetailsCell(reuseIdentifier: "\(RecommendationViewCell.self)",
                            cellType: RecommendationViewCell.self,
                            data: data)
                
                self.cellData.append(cell)
                self.refreshView?(cell)
            }
        }
    }
}
