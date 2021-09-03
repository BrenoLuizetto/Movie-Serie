//
//  HomeCollectionView.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 01/07/21.
//

import Foundation
import UIKit

enum collectionType {
    case recommendation
    case homeMovies
    case searchMovies
}

class MovieCollectionView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    var movie: Array<MovieViewData> = []
    private var images: Array<UIImage> = []
    private var itemsInSection = 0
    private var collectionType: collectionType?
    private var viewModel: MovieDetailsViewModel?
    public var collectionProtocol: MovieCollectionProtocol?
    public weak var detailsProtocol: MovieDetailsProtocol?
    
    func setup(movie: Array<MovieViewData>?, collectionType: collectionType, viewModel: MovieDetailsViewModel?) {
        self.collectionType = collectionType
        switch collectionType {
        case .homeMovies:
            if let movies = movie {
                self.movie = movies
                self.itemsInSection = Int(movies.count * 5000)
                let midIndexPath = IndexPath(row: Int(itemsInSection) / 2, section: 0)
                  self.scrollToItem(at: midIndexPath,
                                                   at: .centeredHorizontally,
                                             animated: false)
            }
            self.reloadData()
        case .recommendation:
            if let model = viewModel {
                self.viewModel = model
                self.getReccomendations(viewModel: model)
                self.isScrollEnabled = false
                
            }
            break
        case .searchMovies:
            break
        }
        
    }
    
    func registerCell() {
        self.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeConstats.cellIdentifier.movieCollection)
        self.delegate = self
        self.dataSource = self
    }
    
    private func getReccomendations(viewModel: MovieDetailsViewModel) {
        viewModel.getRecommendationMovies { [weak self] movies in
            guard let self = self else { return }
            self.movie = movies
            self.itemsInSection = movies.count
            self.reloadData()
        }
    }
    
    func reloadMovies() {
        self.itemsInSection = movie.count
        self.reloadData()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemsInSection
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeConstats.cellIdentifier.movieCollection, for: indexPath) as! HomeCollectionViewCell
        let movies = movie[indexPath.row % movie.count]
        let moviePoster = movies.posterPath
        let imageUrl = URL(string: "\(HomeConstats.url.imageOriginal)\(moviePoster)")
        if let url = imageUrl {
            cell.moviePoster.af.setImage(withURL: url)
        }
        cell.setup()
        
        if collectionType == .recommendation {
            detailsProtocol?.CollectionContentDidChange()
        }
        
        return cell
    }
    
    override class func didChange(_ changeKind: NSKeyValueChange, valuesAt indexes: IndexSet, forKey key: String) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movieTapped = movie[indexPath.row % movie.count]
        self.collectionProtocol?.didSelectItem(movie: movieTapped)
        
    }
}
