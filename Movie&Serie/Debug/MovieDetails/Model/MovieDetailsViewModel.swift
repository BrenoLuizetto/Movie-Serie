//
//  MovieDetailsViewModel.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 06/07/21.
//

import Foundation
import UIKit

class MovieDetailsViewModel {
    
    let movie: MovieViewData
    weak var delegate: HomeProtocol?
    private let service = MovieDetailsService()
    private var detailsData: DetailsViewData?
    
    init(_ movie: MovieViewData, with delegate: HomeProtocol) {
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
        if let imageUrl = URL(string: "https://image.tmdb.org/t/p/original\(backgroundPath)"){
            callback(imageUrl)
        }
    }
    
    func getMoviePoster(callback: @escaping (URL) -> Void) {
        let posterPath = self.movie.posterPath
        if let imageUrl = URL(string: "https://image.tmdb.org/t/p/original\(posterPath)"){
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
    
    func validateTitleLines(_ width: CGFloat) -> Int {
        let numberOfLines = Int(width/24)
        let titleHeight = 45
        let auxHeight = movie.title.count/numberOfLines
        if auxHeight == 0 {
            return 45
        } else {
            return titleHeight * auxHeight
        }
    }
}
