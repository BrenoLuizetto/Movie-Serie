//
//  RecommendationViewData.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 04/08/22.
//

import Foundation

struct RecommendatioViewData {
    
    let movies: [MovieViewData]
    
    weak var collectionProtocol: MovieCollectionProtocol?
    
}
