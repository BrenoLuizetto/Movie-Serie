//
//  MovieDetailsView.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 03/07/21.
//

import Foundation
import UIKit
import SnapKit
import youtube_ios_player_helper

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
    
    private lazy var mainContainer: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var detailsContainer: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var movieTrailer: YTPlayerView = {
        let movieTrailer = YTPlayerView()
        movieTrailer.contentMode = .scaleAspectFit
        movieTrailer.layer.cornerRadius = 5
        movieTrailer.layer.masksToBounds = true
        return movieTrailer
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
        lbl.font = UIFont(name: Constants.Fonts.avenirMedium, size: 18)
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
        label.font = UIFont(name: Constants.Fonts.avenirHeavy, size: 30)
        label.lineBreakMode = .byTruncatingTail
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var movieDescription: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.Fonts.avenirMedium, size: 18)
        label.textColor = .white
        label.numberOfLines = 0
        label.fitTextToBounds()
        return label
    }()
    
    private lazy var releaseDate: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: Constants.Fonts.avenirMedium, size: 18)
        lbl.textColor = .white
        lbl.textAlignment = .left
        return lbl
    }()
    
    private lazy var favoriteButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "plus"), for: .normal)
        btn.setTitle("Minha Lista", for: .normal)
        btn.backgroundColor = .clear
        btn.imageView?.tintColor = .white
        btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 60, bottom: 10, right: 0)
        btn.titleEdgeInsets = UIEdgeInsets(top: 30, left: 0, bottom: 0.0, right: 0)
        btn.addTarget(self, action: #selector(addFavorite(sender:)), for: .touchUpInside)
        return btn
    }()
    
    private lazy var playButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "play"), for: .normal)
        btn.setTitle("Assistir", for: .normal)
        btn.backgroundColor = .clear
        btn.imageView?.tintColor = .white
        btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 60, bottom: 10, right: 0)
        btn.titleEdgeInsets = UIEdgeInsets(top: 30, left: 0, bottom: 0.0, right: 0)
        return btn
    }()
    
    private lazy var separator: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        return view
    }()
    
    private lazy var recommendationTitle: UILabel = {
       let lbl = UILabel()
        lbl.text = "Recomendações"
        lbl.font = UIFont(name: Constants.Fonts.avenirHeavy, size: 18)
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
        setItens()
   }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configRecommendationCollection() {
        self.recommendationCollection.registerCell()
        self.recommendationCollection.collectionProtocol = self.delegate
        self.recommendationCollection.detailsProtocol = self
        self.recommendationCollection.setup(movie: nil, collectionType: .recommendation, viewModel: viewModel)
    }
    func getTrailer() {
        self.viewModel.getTrailer { [weak self] result in
            guard let self = self else {return}
            if let trailer = result.results.first {
                self.movieTrailer.load(withVideoId: trailer.key)
                self.movieTrailer.playVideo()
                
                self.movieTrailer.removeHUD()
                self.backgroundMovie.removeHUD()
            } else {
                self.viewModel.getMovieBackground(callback: { result in
                    self.buildEmptyTrailer()
                    self.backgroundMovie.af.setImage(withURL: result)
                    self.movieTrailer.removeHUD()
                    self.backgroundMovie.removeHUD()
                })
                
            }
        }
    }
    
    func setItens() {
        self.backgroundMovie.showHUD()
        self.movieTrailer.showHUD()
        configRecommendationCollection()
        buildItens()
        verifyFavoriteList()
        getTrailer()
        verifyCollectionItens()
        getValues()
    }
    
    private func getValues() {
        self.movieTitle.text = self.viewModel.movie.title
        let movieRating = Int(self.viewModel.movie.voteAverage * 10)
        if movieRating == 0 {
            self.movieRating.text = Constants.Labels.inComing
        } else {
            self.movieRating.text = String("\(movieRating)% relevante")
        }
        self.releaseDate.text = self.viewModel.movie.releaseDate
        self.movieDescription.text = self.viewModel.movie.overview
        if self.releaseDate.text?.count ?? 0 > 4 {
            self.releaseDate.text?.removeLast(6)
        }
    }
    
    private func verifyCollectionItens() {
        if recommendationCollection.movie.isEmpty {
            self.separator.isHidden = true
            self.recommendationTitle.isHidden = true
        } else {
            self.separator.isHidden = false
            self.recommendationTitle.isHidden = false
        }
    }
    
    private func buildEmptyTrailer() {
        movieTrailer.isHidden = true
        
        self.addSubview(backgroundMovie)
        backgroundMovie.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(80)
            make.left.right.equalToSuperview()
            make.height.equalTo(250)
        }
    }
    
    func setScrollView() {
        self.scrollView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.scrollView.contentSize = (CGSize(width: UIScreen.main.bounds.width,
                                              height: self.recommendationCollection.contentSize.height +
                                                self.detailsContainer.bounds.height))
        self.scrollView.isScrollEnabled = true
        self.scrollView.alwaysBounceVertical = true
        self.scrollView.isUserInteractionEnabled = true
        verifyCollectionItens()
    }
    
    private func verifyFavoriteList() {
        if viewModel.validateFavoriteList() {
            self.favoriteButton.setImage(UIImage(systemName: "checkmark"), for: .normal)
        } else {
            self.favoriteButton.setImage(UIImage(systemName: "plus"), for: .normal)
        }
    }
    
    @objc
    private func addFavorite(sender: UIBarButtonItem) {
        self.viewModel.addFavorite {
            self.verifyFavoriteList()
        }
    }
}

extension MovieDetailsView: BuildViewConfiguration {
    func makeConstraints() {
        movieTrailer.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(80)
            make.left.right.equalToSuperview()
            make.height.equalTo(250)
        }
        
        mainContainer.snp.makeConstraints { make in
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
            make.top.equalTo(self.movieTrailer.snp.bottom)
            make.bottom.equalTo(self.snp.bottom)
            
        }
        
        scrollView.snp.makeConstraints { make in
            make.left.right.top.equalTo(self.mainContainer)
            make.bottom.equalTo(self)
        }
        
        detailsContainer.snp.makeConstraints { make in
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
            make.top.equalTo(self.scrollView.snp.top)
            make.bottom.equalTo(self.recommendationCollection.snp.top)
            
        }

        movieTitle.snp.makeConstraints { make in
            make.top.equalTo(self.detailsContainer.snp.top).offset(5)
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
        }
        
        favoriteButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview().offset(-90)
            make.width.equalTo(120)
            make.top.equalTo(self.movieDescription.snp.bottom).offset(15)
        }
        
        playButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview().offset(75)
            make.width.equalTo(120)
            make.top.equalTo(self.movieDescription.snp.bottom).offset(15)
        }

        separator.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalTo(self.detailsContainer.snp.right).offset(-16)
            make.top.equalTo(favoriteButton.snp.bottom).offset(40)
            make.height.equalTo(1)
        }
        
        recommendationTitle.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.top.equalTo(separator.snp.bottom).offset(10)
            make.bottom.equalTo(detailsContainer.snp.bottom).offset(-5)
        }
        
        recommendationCollection.snp.makeConstraints { make in
            make.left.equalTo(self.snp.left).offset(30)
            make.right.equalTo(self.snp.right).offset(-30)
            make.bottom.equalTo(self.mainContainer.snp.bottom).offset(-15)
        }
        
    }
    
    func buildViewHierarchy() {
        self.addSubview(movieTrailer)
        self.addSubview(mainContainer)
        mainContainer.addSubview(scrollView)
        scrollView.addSubview(detailsContainer)
        self.detailsContainer.addSubview(movieTitle)
        self.detailsContainer.addSubview(movieRating)
        self.detailsContainer.addSubview(releaseDate)
        self.detailsContainer.addSubview(movieDescription)
        self.detailsContainer.addSubview(favoriteButton)
        self.detailsContainer.addSubview(playButton)
        self.detailsContainer.addSubview(separator)
        self.scrollView.addSubview(recommendationTitle
        )
        self.scrollView.addSubview(recommendationCollection)
    }
    
    func configElements() {
        
    }
}

extension MovieDetailsView: MovieDetailsProtocol {
    func CollectionContentDidChange() {
        self.setScrollView()
    }
}
