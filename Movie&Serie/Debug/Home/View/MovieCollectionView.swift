//
//  HomeCollectionView.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 01/07/21.
//

import Foundation
import UIKit

enum CollectionType {
    case recommendation
    case homeMovies
    case searchMovies
}

class MovieCollectionView: UICollectionView,
                           UICollectionViewDataSource,
                           UICollectionViewDelegate,
                           UICollectionViewDelegateFlowLayout {
    var movie: [MovieViewData] = []
    private var images: [UIImage] = []
    private var itemsInSection = 0
    private var collectionType: CollectionType?
    private var viewModel: MovieDetailsViewModel?
    public var collectionProtocol: MovieCollectionProtocol?
    public weak var detailsProtocol: MovieDetailsProtocol?
    
    func setup(movie: [MovieViewData]?,
               collectionType: CollectionType,
               viewModel: MovieDetailsViewModel?) {
        self.collectionType = collectionType
        switch collectionType {
        case .homeMovies:
            if let movies = movie {
                self.movie = movies
                self.itemsInSection = movies.count
            }
            reloadWithTransition()
        case .recommendation:
            if let model = viewModel {
                self.viewModel = model
                self.getReccomendations(viewModel: model)
                self.isScrollEnabled = false
                
            }
        case .searchMovies:
            guard let movies = movie else { return }
            self.movie = movies
            self.reloadMovies()
        }
        
    }
    
    func registerCell() {
        self.backgroundColor = .black
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.register(HomeCollectionViewCell.self,
                      forCellWithReuseIdentifier: Constants.CellIdentifier.movieCollection)
        self.delegate = self
        self.dataSource = self
    }
    
    private func getReccomendations(viewModel: MovieDetailsViewModel) {
        viewModel.getRecommendationMovies { [weak self] movies in
            guard let self = self else { return }
            self.movie = movies
            self.itemsInSection = movies.count
            self.reloadWithTransition()
        }
    }
    
    func reloadMovies() {
        self.itemsInSection = movie.count
        reloadWithTransition()
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return itemsInSection
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CellIdentifier.movieCollection,
                                                            for: indexPath) as? HomeCollectionViewCell
        else { return UICollectionViewCell() }
        let movies = movie[indexPath.row % movie.count]
        let moviePoster = movies.posterPath
        let imageUrl = URL(string: "\(Constants.Url.imageOriginal)\(moviePoster)")
        if let url = imageUrl {
            cell.moviePoster.af.setImage(withURL: url)
        }
        cell.setup()
        
        if collectionType == .recommendation {
            detailsProtocol?.CollectionContentDidChange()
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movieTapped = movie[indexPath.row % movie.count]
        self.collectionProtocol?.didSelectItem(movie: movieTapped)
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.collectionProtocol?.didScroll()
    }
}
