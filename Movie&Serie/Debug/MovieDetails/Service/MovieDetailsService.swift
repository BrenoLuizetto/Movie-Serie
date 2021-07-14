//
//  MovieDetailsService.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 08/07/21.
//

import Foundation
import Alamofire

class MovieDetailsService: NSObject {
    let headerMovie = "https://api.themoviedb.org/3/"
    let opkey = HomeConstats.OPKeys().movieOPKey
    
    func getDetails(type: String, id: String, with callback: @escaping (MovieDetails) -> Void) {
        guard let url = URL(string:"\(headerMovie)\(type)/\(id)?api_key=\(opkey)&language=pt-BR") else {return}
        let request = AF.request(url, method: .get)
        
        request.responseJSON { response in
            switch response.result{
                
            case .success:
                do {
                    guard let data = response.data else {return}
                    let movieObject = try JSONDecoder().decode(MovieDetails.self, from: data)
                    callback(movieObject)
                } catch let erro {
                    print("@@@\(erro)")
                }
            case .failure:
            print(response.error!)
            }
        }
    }
}
