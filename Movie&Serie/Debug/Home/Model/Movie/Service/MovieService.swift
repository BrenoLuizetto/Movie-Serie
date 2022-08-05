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
    let opkey = Constants.OPKeys.movieOPKey
    
    func getMovie<T: Decodable>(_ url: URL, with callback: @escaping (T?, Error?) -> Void) {
        let request = AF.request(url, method: .get)
        
        request.responseJSON { response in
            switch response.result {
                
            case .success:
                do {
                    guard let data = response.data else {return}
                    let movieObject = try JSONDecoder().decode(T.self, from: data)
                    callback(movieObject, nil)
                } catch let erro {
                    callback(nil, erro)
                }
            case .failure(let error):
                callback(nil, error)
            }
        }
    }
}
