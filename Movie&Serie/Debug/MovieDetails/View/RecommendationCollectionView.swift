//
//  RecommendationCollectionView.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 21/07/21.
//

import Foundation
import UIKit

class RecommendationCollectionView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    private var viewModel: MovieDetailsViewModel?
    private var movieData: Array<MovieViewData> = []
    private var numberOfRows = 0
    
    private func registerCell() {
        self.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: "MovieCollectionCell")
        self.delegate = self
        self.dataSource = self
    }
        
    func getMovie(movieType: [MovieType],_ callback: @escaping () -> Void) {
            movieData = []
            viewModel?.getRecommendationMovies { movies in
                self.movieData = movies
                self.reloadData()
                callback()
            }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionCell", for: indexPath) as! HomeCollectionViewCell
        
        return cell

    }
    
    
    
}
