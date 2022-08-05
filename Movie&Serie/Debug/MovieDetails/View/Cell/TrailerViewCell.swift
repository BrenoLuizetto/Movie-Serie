//
//  TrailerViewCell.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 15/07/22.
//

import Foundation
import UIKit
import youtube_ios_player_helper

struct TrailerViewData {
    
    var key: String?
    
    var url: URL?
    
}

final class TrailerViewCell: DetailsViewCell {
    
    private let topMargin: CGFloat = 80
    private let contentHeight: CGFloat = 250
    
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
    
    var viewData: TrailerViewData?
        
    override func setup<T>(data: T) {
        self.viewData = data as? TrailerViewData
        
        setupViewConfiguration()
        setTrailer(viewData?.key)
    }
    
    func setTrailer(_ key: String?) {
        if let key = key {
            self.movieTrailer.load(withVideoId: key)
            self.movieTrailer.playVideo()
        } else {
            setupPoster()
        }
    }
    
    func setupPoster() {
        if let url = viewData?.url {
            movieTrailer.removeConstraints(movieTrailer.constraints)
            movieTrailer.removeFromSuperview()
            self.contentView.addSubview(backgroundMovie)
            backgroundMovie.snp.makeConstraints { make in
                make.top.left.right.bottom.equalToSuperview()
                make.height.equalTo(contentHeight)
            }
            self.backgroundMovie.af.setImage(withURL: url)
        }
    }
    
}

extension TrailerViewCell: BuildViewConfiguration {
    func buildViewHierarchy() {
        self.contentView.addSubview(movieTrailer)
    }
    
    func makeConstraints() {
        movieTrailer.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
            make.height.equalTo(contentHeight)
        }
    }
    
    func configElements() {
        self.backgroundColor = .clear
    }
}
