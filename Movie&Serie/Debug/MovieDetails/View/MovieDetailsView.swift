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
    
    private lazy var genresContainer: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 20
        stack.alignment = .center
        stack.distribution = .fill
        return stack
    }()
    
    private lazy var buttonsContainer: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 20
        stack.alignment = .center
        stack.distribution = .fill
        return stack
    }()
    
    private lazy var favoriteButton: UIButton = {
        var filled = UIButton.Configuration.filled()
        filled.title = Constants.Labels.myList
        filled.buttonSize = .small
        filled.image = UIImage(systemName: Constants.Images.plus)
        filled.imagePlacement = .top
        filled.imagePadding = 5
        filled.baseBackgroundColor = .clear
        let btn = UIButton(configuration: filled, primaryAction: nil)
        btn.addTarget(self, action: #selector(addFavorite(sender:)), for: .touchUpInside)
        return btn
    }()
    
    private lazy var playButton: UIButton = {
        var filled = UIButton.Configuration.filled()
        filled.title = Constants.Labels.watch
        filled.buttonSize = .small
        filled.image = UIImage(systemName: Constants.Images.play)
        filled.imagePlacement = .top
        filled.imagePadding = 5
        filled.baseBackgroundColor = .clear
        let btn = UIButton(configuration: filled, primaryAction: nil)
        btn.addTarget(self, action: #selector(streamMovie(sender:)), for: .touchUpInside)
        return btn
    }()
    
    private lazy var separator: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        return view
    }()
    
    private lazy var recommendationTitle: UILabel = {
       let lbl = UILabel()
        lbl.text = Constants.Labels.recommendations
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
    private var hasGenre: Bool = false
    
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
                self.buildEmptyTrailer()
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
        setGenres()
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
        if let url = self.viewModel.getMovieBackground() {
            movieTrailer.removeConstraints(movieTrailer.constraints)
            movieTrailer.removeFromSuperview()
            self.addSubview(backgroundMovie)
            backgroundMovie.snp.makeConstraints { make in
                make.top.equalTo(self.snp.top).offset(80)
                make.left.right.equalToSuperview()
                make.height.equalTo(250)
            }
            
            mainContainer.snp.makeConstraints { make in
                make.top.equalTo(backgroundMovie.snp.bottom)
            }
            self.backgroundMovie.af.setImage(withURL: url)
            self.movieTrailer.removeHUD()
            self.backgroundMovie.removeHUD()
        } else {
            movieTrailer.removeFromSuperview()
            mainContainer.snp.makeConstraints { make in
                make.top.edges.equalToSuperview()
            }
        }
        self.updateConstraints()
        self.layoutIfNeeded()
    }
    
    func setScrollView() {
        self.layoutIfNeeded()
        self.scrollView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.scrollView.contentSize = (CGSize(width: UIScreen.main.bounds.width,
                                              height: self.recommendationCollection.contentSize.height +
                                                self.detailsContainer.bounds.height))
        self.scrollView.isScrollEnabled = true
        self.scrollView.alwaysBounceVertical = true
        self.scrollView.isUserInteractionEnabled = true
        verifyCollectionItens()
        UIAccessibility.post(notification: .layoutChanged,
                             argument: scrollView)
        
    }
    
    private func verifyFavoriteList() {
        if viewModel.validateFavoriteList() {
            self.favoriteButton.setImage(UIImage(systemName: Constants.Images.checkmark), for: .normal)
        } else {
            self.favoriteButton.setImage(UIImage(systemName: Constants.Images.plus), for: .normal)
        }
    }
    
    private func setGenres() {
        viewModel.getDetailsMovie {
            guard let genres = self.viewModel.movieDetails?.genres else {
                self.hasGenre = false
                self.genresContainer.removeFromSuperview()
                return
            }
            self.genresContainer.removeAllViews()
            var count = 0
            for genre in genres {
                if count > 3 {
                    return
                }
                let lbl = UILabel()
                lbl.font = UIFont(name: Constants.Fonts.avenirHeavy, size: 16)
                lbl.textColor = .lightGray
                lbl.text = genre.name
                lbl.lineBreakMode = .byTruncatingTail
                self.genresContainer.addArrangedSubview(lbl)
                count += count + 1
            }
            self.hasGenre = true
//            self.removeAllViews()
//            self.buildItens()
        }
    }
    
    @objc
    private func addFavorite(sender: UIBarButtonItem) {
        self.viewModel.addFavorite {
            self.verifyFavoriteList()
        }
    }
    
    @objc
    private func streamMovie(sender: UIButton) {
        self.showHUD()
        self.viewModel.getDetailsMovie {
            self.viewModel.openMovieStream()
            self.removeHUD()
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
        
        if hasGenre {
            genresContainer.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalTo(self.movieDescription.snp.bottom).offset(15)
            }
        }
        
        buttonsContainer.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(240)
            if hasGenre {
                make.top.equalTo(self.genresContainer.snp.bottom).offset(15)
            } else {
                make.top.equalTo(self.movieDescription.snp.bottom).offset(15)
            }
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
        self.detailsContainer.addSubview(genresContainer)
        self.detailsContainer.addSubview(buttonsContainer)
        self.buttonsContainer.addArrangedSubview(favoriteButton)
        self.buttonsContainer.addArrangedSubview(playButton)
        self.detailsContainer.addSubview(separator)
        self.scrollView.addSubview(recommendationTitle)
        self.scrollView.addSubview(recommendationCollection)
    }
    
    func configElements() {
        self.setScrollView()
    }
}

extension MovieDetailsView: MovieDetailsProtocol {
    func CollectionContentDidChange() {
        self.setScrollView()
    }
}
