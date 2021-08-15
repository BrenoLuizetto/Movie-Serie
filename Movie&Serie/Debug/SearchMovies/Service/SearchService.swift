//
//  SearchService.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 26/07/21.
//

import Foundation
import Alamofire

class SearchService: NSObject {
    let headerMovie = "https://api.themoviedb.org/3/"
    let opkey = HomeConstats.OPKeys().movieOPKey
    
    func getMovie(query: String, with callback: @escaping (Movie?, Error?) -> Void) {
        guard let url = URL(string:"\(headerMovie)search/multi?api_key=\(opkey)&query=\(query)&language=pt-BR&page=1") else
        {return}
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
    
    func getGenres(type: String, genres: String, with callback: @escaping (Genre?) -> Void) {
        guard let url = URL(string:"\(headerMovie)\(type)api_key=\(opkey)\(genres)&language=pt-BR&page=1") else {return}
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
}
