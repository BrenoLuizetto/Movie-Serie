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
import Alamofire

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
    
    private lazy var infoContainer: InfoContainerViewCell = {
        let view = InfoContainerViewCell()
        return view
    }()
    
    
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

    
    func setItens() {
        setupViewConfiguration()
        verifyFavoriteList()
        getValues()
        setGenres()
    }
    
    private func getValues() {
        let title = viewModel.movie.title
        let movieRating = Int(viewModel.movie.voteAverage * 10)
        let rating = movieRating == 0 ? Constants.Labels.inComing : String("\(movieRating)% relevante")
        var release = viewModel.movie.releaseDate
        let description = viewModel.movie.overview
        
        if release.count > 4 {
            release.removeLast(6)
        }
        
        infoContainer.setItens(title: title,
                               rating: rating,
                               release: release,
                               description: description,
                               isFavorite: true)
    }

    
    func setScrollView() {
        self.layoutIfNeeded()
        self.scrollView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        print("@@@\(mainContainer.bounds.width)")
        self.scrollView.contentSize = (CGSize(width: mainContainer.bounds.width,
                                              height: mainContainer.bounds.height))
        self.scrollView.isScrollEnabled = true
        self.scrollView.alwaysBounceVertical = true
        self.scrollView.isUserInteractionEnabled = true
        UIAccessibility.post(notification: .layoutChanged,
                             argument: scrollView)
        
    }
    
    private func verifyFavoriteList() {
    }
    
    private func setGenres() {
        viewModel.getDetailsMovie {
            guard let genres = self.viewModel.movieDetails?.genres else {
                self.infoContainer.hasGenre = false
                self.infoContainer.genresContainer.removeFromSuperview()
                return
            }
            self.infoContainer.genresContainer.removeAllViews()
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
                self.infoContainer.genresContainer.addArrangedSubview(lbl)
                count += count + 1
            }
            self.infoContainer.hasGenre = true
//            self.removeAllViews()
//            self.buildItens()
        }
    }
    
    @objc
    private func addFavorite(sender: UIBarButtonItem) {
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
        mainContainer.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
        
        scrollView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalTo(mainContainer)
        }
        
        infoContainer.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
//            make.bottom.equalTo(self.recommendationCollection.snp.top)
            
        }
        
    }
    
    func buildViewHierarchy() {
        self.addSubview(mainContainer)
        mainContainer.addSubview(scrollView)
        self.scrollView.addSubview(infoContainer)

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
