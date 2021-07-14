//
//  HomeCollectionView.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 01/07/21.
//

import Foundation
import UIKit

protocol HomeProtocol: AnyObject {
    func didSelectItem(movie: MovieViewData)
    func finishLoad()
    func hiddenTabBar(hidden: Bool, animated: Bool)
    func showDetailsScreen(movie: MovieViewData)
    func buildConstraints()
}

class HomeCollectionView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    private var movie: Array<MovieViewData> = []
    private var images: Array<UIImage> = []
    private var infiniteSize = 0.0
    public var collectionProtocol: HomeProtocol?
    
    func setup(movie: Array<MovieViewData>) {
        self.movie = movie
        self.infiniteSize = Double(movie.count * 5000)
        let midIndexPath = IndexPath(row: Int(infiniteSize) / 2, section: 0)
          self.scrollToItem(at: midIndexPath,
                                           at: .centeredHorizontally,
                                     animated: false)
        self.reloadData()
    }
    
    func registerCell() {
        self.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: "MovieCollectionCell")
        self.delegate = self
        self.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Int(infiniteSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionCell", for: indexPath) as! HomeCollectionViewCell
        let movies = movie[indexPath.row % movie.count]
        let moviePoster = movies.posterPath
        let imageUrl = URL(string: "https://image.tmdb.org/t/p/original\(moviePoster)")
        if let url = imageUrl {
            cell.moviePoster.af_setImage(withURL: url)
        }
        cell.setup()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movies = movie[indexPath.row % movie.count]
        self.collectionProtocol?.didSelectItem(movie: movies)
        
    }
    
    
}
