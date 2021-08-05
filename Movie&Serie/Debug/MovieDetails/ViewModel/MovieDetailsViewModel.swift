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
    private let service = MovieDetailsService()
    private var detailsData: DetailsViewData?
    
    init(_ movie: MovieViewData, with delegate: MovieCollectionProtocol) {
        self.movie = movie
        self.delegate = delegate
    }
    
    func getMovieDetails(_ callback: @escaping (DetailsViewData?) -> Void) {
        if let type =  movie.mediaType {
            service.getDetails(type: type, id: String(self.movie.id)) { result in
                self.detailsData = DetailsViewData(model: result)
                callback(self.detailsData)
            }
        }
       callback(nil)
    }
    
    func getMovieBackground(callback: @escaping (URL) -> Void) {
        guard let backgroundPath = self.movie.backdropPath else {return}
        if let imageUrl = URL(string: "\(HomeConstats.url.imageOriginal)\(backgroundPath)"){
            callback(imageUrl)
        }
    }
    
    func getMoviePoster(callback: @escaping (URL) -> Void) {
        let posterPath = self.movie.posterPath
        if let imageUrl = URL(string: "\(HomeConstats.url.imageOriginal)\(posterPath)"){
            callback(imageUrl)
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
    
    func getRecommendationMovies(_ callback: @escaping (Array<MovieViewData>) -> Void) {
        let id = String(movie.id)
        service.getrecommendationMovies(id) { recommendation in
            if let recommendationList = recommendation.results {
                self.recommendationMovieData = []
                for movies in recommendationList {
                        self.recommendationMovieData.append(MovieViewData(model: movies))
                }
                
            }
            callback(self.recommendationMovieData)
        }
    }

}
