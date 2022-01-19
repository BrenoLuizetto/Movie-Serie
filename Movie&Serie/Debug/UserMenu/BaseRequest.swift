//
//  BaseRequest.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 20/12/21.
//

import Foundation

enum RequestResult<T> {
    case success(T)
    case error
}

class BaseRequest {
    
    internal func request<T: Decodable>(filename: String, completion: @escaping (RequestResult<T>) -> Void) {
        guard let path = Bundle(for: type(of: self)).path(forResource: filename, ofType: "json") else { return }
        if let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
            do {
                print(data)
                print(path)
                print(T.self)
                let object = try JSONDecoder().decode(T.self, from: data)
                completion(.success(object))
            } catch {
                print(error.localizedDescription)
                completion(.error)
            }
        }
    }
}
