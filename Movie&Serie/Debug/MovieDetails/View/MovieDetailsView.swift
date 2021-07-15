//
//  MovieDetailsView.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 03/07/21.
//

import Foundation
import UIKit
import SnapKit

class MovieDetailsView: UIView {
    
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        return scroll
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
        lbl.font = UIFont(name: "Avenir-Medium", size: 18)
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
        label.font = UIFont(name: "Avenir-Heavy", size: 30)
        label.lineBreakMode = .byTruncatingTail
        label.textColor = .white
        label.numberOfLines = 3
        return label
    }()
    
    private let movieDescription: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private var releaseDate: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Avenir-Medium", size: 18)
        lbl.textColor = .white
        return lbl
    }()
    
    private var viewModel: MovieDetailsViewModel
    private var originHeight: CGFloat
    
    init(_ viewModel: MovieDetailsViewModel, originHeight: CGFloat) {
        self.viewModel = viewModel
        self.originHeight = originHeight
        super.init(frame: CGRect())
    
        buildItems()
        self.buildImages()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildImages() {
        self.viewModel.getMovieBackground(callback: { result in
            self.backgroundMovie.af_setImage(withURL: result)
        })
        self.movieTitle.text = self.viewModel.movie.title
        let movieRating = Int(self.viewModel.movie.voteAverage * 10)
        self.movieRating.text = String("\(movieRating)% relevante")
        self.releaseDate.text = self.viewModel.movie.releaseDate
        if self.releaseDate.text?.count ?? 0 > 4 {
            self.releaseDate.text?.removeLast(6)
        }
    }
    
}

extension MovieDetailsView: BuildViewConfiguration {
    func makeConstraints() {
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(80)
            make.left.right.bottom.equalToSuperview()
        }
        
        viewAux.snp.makeConstraints { make in
            make.left.equalTo(self.scrollView.snp.left)
            make.right.equalTo(self.scrollView.snp.right)
            make.top.equalTo(self.scrollView.snp.top)
            make.bottom.equalTo(self.scrollView.snp.bottom)

        }
        
        backgroundMovie.snp.makeConstraints { make in
            make.left.equalTo(self.viewAux.snp.left)
            make.right.equalTo(self.viewAux.snp.right)
            make.top.equalTo(self.viewAux.snp.top)
            make.height.equalTo(250)
        }
        
        movieTitle.snp.makeConstraints { make in
            make.top.equalTo(self.backgroundMovie.snp.bottom).offset(5)
            make.left.equalTo(self.snp.left).offset(15)
            make.right.equalTo(self.snp.right).offset(-15)
            make.height.equalTo(viewModel.validateTitleLines(originHeight)
)
        }
        
        movieRating.snp.makeConstraints { make in
            make.top.equalTo(self.movieTitle.snp.bottom).offset(5)
            make.left.equalTo(self.snp.left).offset(15)
            make.width.equalTo(120)
            make.height.equalTo(30)
        }
        
        releaseDate.snp.makeConstraints { make in
            make.top.equalTo(self.movieTitle.snp.bottom).offset(5)
            make.left.equalTo(movieRating.snp.right).offset(10)
            make.width.equalTo(50)
            make.height.equalTo(30)
        }
        
    }
    
    func buildViewHierarchy() {
        self.addSubview(scrollView)
        self.addSubview(viewAux)
        viewAux.addSubview(backgroundMovie)
        viewAux.addSubview(movieTitle)
        viewAux.addSubview(movieRating)
        viewAux.addSubview(releaseDate)
    }
    
    func configElements() {
        //Not Implemented
    }
    
}
