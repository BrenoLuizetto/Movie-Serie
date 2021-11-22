//
//  MovieDetailsViewModel.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 06/07/21.
//

import Foundation
import UIKit

class MovieDetailsViewModel: MovieViewModel {
    
    let movie: MovieViewData
    var recommendationMovieData: Array<MovieViewData> = []
    weak var delegate: MovieCollectionProtocol?
    private let service = MovieService()
    private var detailsData: DetailsViewData?
    
    init(_ movie: MovieViewData, with delegate: MovieCollectionProtocol) {
        self.movie = movie
        self.delegate = delegate
    }
    
    func getMovieBackground(callback: @escaping (URL) -> Void) {
        guard let backgroundPath = self.movie.backdropPath else {return}
        if let imageUrl = URL(string: "\(Constants.Url.imageOriginal)\(backgroundPath)") {
            callback(imageUrl)
        }
    }
    
    func getMoviePoster(callback: @escaping (URL) -> Void) {
        let posterPath = self.movie.posterPath
        if let imageUrl = URL(string: "\(Constants.Url.imageOriginal)\(posterPath)") {
            callback(imageUrl)
        }
    }
    
    func getTrailer(callback: @escaping (MovieTrailer) -> Void) {
        guard let url = URL(string: "\(Constants.Url.movieHeader)\(movie.mediaType.rawValue)/\(movie.id)" + "/videos?\(Constants.OPKeys().movieOPKey)\(Constants.Url.language)") else {return}
        
        service.getMovieTrailers(url) { result in
            callback(result)
        }
    }
    
    func applyBlurEffect(image: UIImage) -> UIImage {
        let imageToBlur = CIImage(image: image)
        let blurfilter = CIFilter(name: "CIGaussianBlur")
        blurfilter?.setValue(imageToBlur, forKey: "inputImage")
        guard let resultImage = blurfilter?.value(forKey: "outputImage") as? CIImage else { return UIImage() }
        let blurredImage = UIImage(ciImage: resultImage)
        return blurredImage
      }
    
    func getRecommendationMovies(_ callback: @escaping ([MovieViewData]) -> Void) {
        let id = String(movie.id)
        guard let url = URL(string: "\(Constants.Url.movieHeader)\(movie.mediaType.rawValue)/" +
                            "\(id)/recommendations?\(Constants.OPKeys().movieOPKey)" +
                            "\(Constants.Url.language)") else {return}
        service.getMovie(url) { recommendation, error  in
            if let recommendationList = recommendation?.results {
                self.recommendationMovieData = []
                for movies in recommendationList {
                        self.recommendationMovieData.append(MovieViewData(model: movies))
                }
                
            }
            callback(self.recommendationMovieData)
        }
    }
    
    func addFavorite(with callback: @escaping () -> Void) {
        let us = UserDefaults.standard
        do {
            do {
                var movieArray = try us.getObject(forKey: Constants.UserDefaults.favoriteMovies,
                                                  castTo: [MovieViewData].self)
                if !validateUserDefault(movieArray: movieArray) {
                    movieArray.append(self.movie)
                    try us.setObject(movieArray, forKey: Constants.UserDefaults.favoriteMovies)
                    callback()
                } else {
                    movieArray.removeAll(where: {$0.id == movie.id})
                    try? us.setObject(movieArray, forKey: Constants.UserDefaults.favoriteMovies)
                    callback()
                }
            } catch {
                let movieArray = [self.movie]
                try us.setObject(movieArray, forKey: Constants.UserDefaults.favoriteMovies)
                callback()
            }
        } catch {
            print(error.localizedDescription)
            callback()
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
}
