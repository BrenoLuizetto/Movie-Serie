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
    
     public let scrollView: UIScrollView = {
        let scroll = UIScrollView(frame: .zero)
        scroll.isScrollEnabled = true
        scroll.alwaysBounceVertical = true
        return scroll
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let viewAux: UIView = {
        let view = UIView()
        return view
    }()
    
    private var backgroundMovie: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private var movieRating: UILabel = {
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
    
    private var movieTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: HomeConstats.Fonts.avenirHeavy, size: 30)
        label.lineBreakMode = .byTruncatingTail
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private let movieDescription: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: HomeConstats.Fonts.avenirMedium, size: 18)
        label.textColor = .white
        label.numberOfLines = 0
        label.fitTextToBounds()
        return label
    }()
    
    private var releaseDate: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: HomeConstats.Fonts.avenirMedium, size: 18)
        lbl.textColor = .white
        lbl.textAlignment = .left
        return lbl
    }()
    
    private var recommendationCollection: HomeCollectionView = {
        let layout = UICollectionViewFlowLayout()
         layout.itemSize = CGSize(width: CGFloat(150), height: CGFloat(280))
         layout.scrollDirection = .horizontal
        let collection = HomeCollectionView(frame: CGRect(), collectionViewLayout: layout)
        collection.registerCell()
        return collection
    }()
    
    private var viewModel: MovieDetailsViewModel
    private var originWidth: CGFloat
    private var originHeight: CGFloat
    
    init(_ viewModel: MovieDetailsViewModel, originWidth: CGFloat, originHeight: CGFloat) {
        self.viewModel = viewModel
        self.originWidth = originWidth
        self.originHeight = originHeight
        
        super.init(frame: CGRect())
        showLoader()

        scrollView.contentSize = (CGSize(width: originWidth, height: 2000))
        scrollView.isScrollEnabled = true
        scrollView.bounces = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.automaticallyAdjustsScrollIndicatorInsets = false
        scrollView.isScrollEnabled = true
        scrollView.isUserInteractionEnabled = true
        
        
        self.recommendationCollection.setup(movie: nil, collectionType: .recommendation, viewModel: viewModel)
        buildItems()
        scrollView.isScrollEnabled = true
        buildImages()
        
   }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildImages() {
        self.viewModel.getMovieBackground(callback: { result in
            self.backgroundMovie.af_setImage(withURL: result)
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
            make.height.equalTo(2000)
        }
        
        scrollView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalTo(self.viewAux)
        }
        
        contentView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.width.equalToSuperview()
        }

        movieTitle.snp.makeConstraints { make in
            make.top.equalTo(self.backgroundMovie.snp.bottom).offset(5)
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
            make.left.equalTo(self.snp.left).offset(15)
            make.right.equalTo(self.snp.right).offset(-15)
            make.top.equalTo(self.movieDescription.snp.bottom).offset(5)
            make.bottom.equalTo(self.viewAux.snp.bottom).offset(-15)
        }
        
    }
    
    func buildViewHierarchy() {
        self.addSubview(backgroundMovie)
        self.addSubview(viewAux)
        viewAux.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(movieTitle)
        contentView.addSubview(movieRating)
        contentView.addSubview(releaseDate)
        contentView.addSubview(movieDescription)
        contentView.addSubview(recommendationCollection)
    }
    
    func configElements() {
        
    }
}
