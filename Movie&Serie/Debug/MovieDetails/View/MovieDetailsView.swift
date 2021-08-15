//
//  MovieDetailsView.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 03/07/21.
//

import Foundation
import UIKit
import SnapKit

class MovieDetailsView: UIView, UIScrollViewDelegate {
    
     public lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView(frame: .zero)
        scroll.isScrollEnabled = true
        scroll.alwaysBounceVertical = true
        return scroll
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var viewAux: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var backgroundMovie: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private lazy var movieRating: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: HomeConstats.Fonts.avenirMedium, size: 18)
        lbl.textColor = UIColor(rgb: 0x08CA49)
        return lbl
    }()

    private var moviePoster: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var movieTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: HomeConstats.Fonts.avenirHeavy, size: 30)
        label.lineBreakMode = .byTruncatingTail
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var movieDescription: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: HomeConstats.Fonts.avenirMedium, size: 18)
        label.textColor = .white
        label.numberOfLines = 0
        label.fitTextToBounds()
        return label
    }()
    
    private lazy var releaseDate: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: HomeConstats.Fonts.avenirMedium, size: 18)
        lbl.textColor = .white
        lbl.textAlignment = .left
        return lbl
    }()
    
    private lazy var layout: UICollectionViewFlowLayout = {
       let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: CGFloat(150), height: CGFloat(280))
        layout.scrollDirection = .vertical

        return layout
    }()
    
    lazy var recommendationCollection = MovieCollectionView(frame: CGRect(), collectionViewLayout: layout)
    
    private var viewModel: MovieDetailsViewModel    
    weak var delegate: MovieCollectionProtocol?
    
    init(_ viewModel: MovieDetailsViewModel, delegate: MovieCollectionProtocol) {
        self.viewModel = viewModel
        self.delegate = delegate
        
        super.init(frame: CGRect())
        self.recommendationCollection.registerCell()
        self.recommendationCollection.collectionProtocol = self.delegate
        self.recommendationCollection.detailsProtocol = self
        self.recommendationCollection.setup(movie: nil, collectionType: .recommendation, viewModel: viewModel)
        buildItems()
        scrollView.isScrollEnabled = true
        setItems()
        
   }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setItems() {
        self.viewModel.getMovieBackground(callback: { result in
            self.backgroundMovie.af.setImage(withURL: result)
            self.removeLoader()
        })
        self.movieTitle.text = self.viewModel.movie.title
        let movieRating = Int(self.viewModel.movie.voteAverage * 10)
        if movieRating == 0 {
            self.movieRating.text = HomeConstats.labels.inComing
        } else {
            self.movieRating.text = String("\(movieRating)% relevante")
        }
        self.releaseDate.text = self.viewModel.movie.releaseDate
        self.movieDescription.text = self.viewModel.movie.overview
        if self.releaseDate.text?.count ?? 0 > 4 {
            self.releaseDate.text?.removeLast(6)
        }
    }
    
    func setScrollView() {
        self.scrollView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.scrollView.contentSize = (CGSize(width: UIScreen.main.bounds.width,
                                              height: self.recommendationCollection.contentSize.height +
                                                self.movieTitle.bounds.height +
                                                self.releaseDate.bounds.height +
                                                self.movieDescription.bounds.height))
        self.scrollView.isScrollEnabled = true
        self.scrollView.alwaysBounceVertical = true
        self.scrollView.isUserInteractionEnabled = true
    }
}

extension MovieDetailsView: BuildViewConfiguration {
    func makeConstraints() {
        backgroundMovie.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(80)
            make.left.right.equalToSuperview()
            make.height.equalTo(250)
        }
        
        viewAux.snp.makeConstraints { make in
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
            make.top.equalTo(self.backgroundMovie.snp.bottom)
            make.bottom.equalTo(self.snp.bottom)
            
        }
        
        scrollView.snp.makeConstraints { make in
            make.left.right.top.equalTo(self.viewAux)
            make.bottom.equalTo(self)
        }

        movieTitle.snp.makeConstraints { make in
            make.top.equalTo(self.scrollView.snp.top).offset(5)
            make.left.equalTo(self.snp.left).offset(15)
            make.right.equalTo(self.snp.right).offset(-15)
        }
        
        movieRating.snp.makeConstraints { make in
            make.top.equalTo(self.movieTitle.snp.bottom).offset(5)
            make.left.equalTo(self.snp.left).offset(15)
            make.right.equalTo(releaseDate.snp.left).offset(-10)
        }
        
        releaseDate.snp.makeConstraints { make in
            make.top.equalTo(self.movieTitle.snp.bottom).offset(5)
            make.left.equalTo(movieRating.snp.right).offset(10)
            make.width.equalTo(50)
        }
        
        movieDescription.snp.makeConstraints { make in
            make.left.equalTo(self.snp.left).offset(15)
            make.right.equalTo(self.snp.right).offset(-15)
            make.top.equalTo(self.movieRating.snp.bottom).offset(5)
            make.bottom.equalTo(recommendationCollection.snp.top).offset(-15)
        }
        
        recommendationCollection.snp.makeConstraints { make in
            make.left.equalTo(self.snp.left).offset(30)
            make.right.equalTo(self.snp.right).offset(-30)
            make.top.equalTo(self.movieDescription.snp.bottom).offset(5)
            make.bottom.equalTo(self.viewAux.snp.bottom).offset(-15)
        }
        
    }
    
    func buildViewHierarchy() {
        self.addSubview(backgroundMovie)
        self.addSubview(viewAux)
        viewAux.addSubview(scrollView)
        self.scrollView.addSubview(movieTitle)
        self.scrollView.addSubview(movieRating)
        self.scrollView.addSubview(releaseDate)
        self.scrollView.addSubview(movieDescription)
        self.scrollView.addSubview(recommendationCollection)
    }
    
    func configElements() {
        
    }
}

extension MovieDetailsView: MovieDetailsProtocol {
    func CollectionContentDidChange() {
        self.setScrollView()
    }
    
    func collectionIsEmpty() {
        movieDescription.snp.makeConstraints { make in
            make.left.equalTo(self.snp.left).offset(15)
            make.right.equalTo(self.snp.right).offset(-15)
            make.top.equalTo(self.movieRating.snp.bottom).offset(5)
            make.bottom.equalTo(viewAux.snp.bottom).offset(-30)
        }
        self.setScrollView()
    }
}
