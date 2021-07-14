//
//  DetailsModalView.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 14/07/21.
//

import Foundation
import UIKit

class DetailsModalView: UIView {
    
    private let buttonClose: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "closeButton"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(didTapClose(sender:)), for: .touchUpInside)
        return button
    }()
    
    private var moviePoster: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 5
        image.layer.masksToBounds = true
        return image
    }()
    
    private var movieTitle: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 2
        label.font = UIFont(name: "Avenir-Medium", size: 20)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .white
        return label
    }()
    
    private var movieDescription: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 3
        label.font = UIFont(name: "Avenir-Book", size: 15)
        label.textColor = .white
        return label
    }()
    
    private var releaseDate: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 1
        label.font = UIFont(name: "Avenir-Medium", size: 15)
        label.textColor = .white
        label.backgroundColor = UIColor(rgb: 0x3C7AFF)
        label.textAlignment = .center
        label.layer.cornerRadius = 5
        label.layer.masksToBounds = true
        return label
    }()
    
    private var moreInformation: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(rgb: 0x4A4A4A)
        button.setTitle("Mais Informações", for: .normal )
        button.setTitle("Carregando...", for: .selected)
        button.addTarget(self, action: #selector(didTapMoreInformation(sender:)), for: .touchUpInside)
        button.titleLabel?.font = UIFont(name: "Avenir-Medium", size: 18)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        return button
    }()
    
    private var viewModel: MovieDetailsViewModel?
    private var controller: MovieModalViewController?
    
    func buildInfo(_ viewModel: MovieDetailsViewModel, controller: MovieModalViewController) {
        self.viewModel = viewModel
        self.controller = controller
        
        self.viewModel?.getMoviePoster(callback: { result in
            self.moviePoster.af_setImage(withURL: result)
        })
        
        self.movieTitle.text = self.viewModel?.movie.title
        self.movieDescription.text = self.viewModel?.movie.overview
        self.releaseDate.text = self.viewModel?.movie.releaseDate
        if self.releaseDate.text?.count ?? 0 > 4 {
            self.releaseDate.text?.removeLast(6)
        }
        
        buildItems()
    }
    
    @objc func didTapMoreInformation(sender: UIButton!) {
        self.viewModel?.delegate?.hiddenTabBar(hidden: false, animated: true)
        self.controller?.dismiss(animated: true, completion: nil)
        guard let movie = viewModel?.movie else {return}
        self.viewModel?.delegate?.showDetailsScreen(movie: movie)
    }
    
    @objc func didTapClose(sender: UIButton!) {
        self.viewModel?.delegate?.hiddenTabBar(hidden: false, animated: true)
        controller?.dismiss(animated: true, completion: nil)
    }
}


extension DetailsModalView: BuildViewConfiguration {
    func makeConstraints() {
        
        buttonClose.snp.makeConstraints { make in
            make.right.equalTo(self.snp.right).offset(-10)
            make.top.equalTo(self.snp.top).offset(10)
            make.height.equalTo(30)
            make.width.equalTo(30)
        }
        
        moviePoster.snp.makeConstraints { make in
            make.left.equalTo(self.snp.left).offset(10)
            make.top.equalTo(self.snp.top).offset(15)
            make.height.equalTo(175)
            make.width.equalTo(125)
        }
        
        movieTitle.snp.makeConstraints { make in
            make.left.equalTo(self.moviePoster.snp.right).offset(15)
            make.top.equalTo(self.snp.top).offset(15)
            make.right.equalTo(self.buttonClose.snp.left).offset(10)
            make.bottom.equalTo(self.movieDescription.snp.top).offset(5)
        }
        
        if self.viewModel?.movie.overview != "" {
            buildWithDescription()
        } else {
            buildWithouDescription()
        }
        
        moreInformation.snp.makeConstraints { make in
            make.top.equalTo(self.moviePoster.snp.bottom).offset(15)
            make.left.equalTo(self.snp.left).offset(15)
            make.right.equalTo(self.snp.right).offset(-15)
            make.bottom.equalTo(self.snp.bottom).offset(-50)
        }
    }
    
    func buildWithDescription() {
        movieDescription.snp.makeConstraints { make in
            make.left.equalTo(self.moviePoster.snp.right).offset(15)
            make.top.equalTo(self.movieTitle.snp.bottom).offset(5)
            make.right.equalTo(self.buttonClose.snp.left).offset(10)
            make.height.equalTo(80)
        }
        
        releaseDate.snp.makeConstraints { make in
            make.left.equalTo(self.moviePoster.snp.right).offset(15)
            make.top.equalTo(self.movieDescription.snp.bottom).offset(5)
            make.width.equalTo(50)
            make.height.equalTo(30)
        }
        
        self.addSubview(self.movieDescription)
        self.addSubview(self.releaseDate)
    }
    
    func buildWithouDescription() {
        releaseDate.snp.makeConstraints { make in
            make.left.equalTo(self.moviePoster.snp.right).offset(15)
            make.top.equalTo(self.movieTitle.snp.bottom).offset(5)
            make.height.equalTo(30)
            make.width.equalTo(50)
        }
        self.addSubview(self.releaseDate)

    }
    
    func buildViewHierarchy() {
        self.addSubview(buttonClose)
        self.addSubview(moviePoster)
        self.addSubview(movieTitle)
        self.addSubview(movieDescription)
        self.addSubview(releaseDate)
        self.addSubview(moreInformation)
    }
    
    func configElements() {
        //Not Implemented
    }
}
