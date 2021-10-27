//
//  SearchService.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 26/07/21.
//

import Foundation
import Alamofire

class MovieService: NSObject {
    let headerMovie = "https://api.themoviedb.org/3/"
    let opkey = MovieConstants.OPKeys().movieOPKey
    
    func getMovie(_ url: URL, with callback: @escaping (Movie?, Error?) -> Void) {
        let request = AF.request(url, method: .get)
        
        request.responseJSON { response in
            switch response.result{
                
            case .success:
                do {
                    guard let data = response.data else {return}
                    let movieObject = try JSONDecoder().decode(Movie.self, from: data)
                    callback(movieObject, nil)
                } catch let erro {
                    callback(nil, erro)
                }
            case .failure(let error):
                callback(nil, error)
            }
        }
    }
    
    func getGenres(_ url: URL, with callback: @escaping (Genre?) -> Void) {
        let request = AF.request(url, method: .get)
        
        request.responseJSON { response in
            switch response.result{
                
            case .success:
                do {
                    guard let data = response.data else {return}
                    let movieObject = try JSONDecoder().decode(Genre.self, from: data)
                    callback(movieObject)
                } catch let erro {
                    print(erro)
                }
            case .failure(let error):
                print(error)
                callback(nil)
            }
        }
    }
    
    func getMovieTrailers(_ url: URL, with callback: @escaping (MovieTrailer) -> Void) {
        let request = AF.request(url, method: .get)
        
        request.responseJSON { response in
            switch response.result{
                
            case .success:
                do {
                    guard let data = response.data else {return}
                    let movieObject = try JSONDecoder().decode(MovieTrailer.self, from: data)
                    callback(movieObject)
                } catch let erro {
                    print(erro)
                }
            case .failure:
            print(response.error!)
            }
        }
    }

}
