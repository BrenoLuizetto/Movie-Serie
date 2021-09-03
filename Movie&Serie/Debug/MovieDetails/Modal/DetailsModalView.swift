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
        label.font = UIFont(name: HomeConstats.Fonts.avenirMedium, size: 20)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .white
        return label
    }()
    
    private var movieDescription: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 5
        label.font = UIFont(name: HomeConstats.Fonts.avenirBook, size: 15)
        label.textColor = .white
        return label
    }()
    
    private var releaseDate: UILabel = {
        let label = UILabel()
        label.releaseDateLabel()
        return label
    }()
    
    private var moreInformation: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(rgb: 0x4A4A4A)
        button.setTitle("Mais Informações", for: .normal )
        button.setTitle("Carregando...", for: .selected)
        button.titleLabel?.font = UIFont(name: HomeConstats.Fonts.avenirMedium, size: 18)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        return button
    }()
    
    private var viewModel: MovieDetailsViewModel?
    private var controller: MovieModalViewController?
    
    func buildInfo(_ viewModel: MovieDetailsViewModel, controller: MovieModalViewController) {
        self.viewModel = viewModel
        self.controller = controller
        setValues()
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
    
    private func setValues() {
        self.movieTitle.text = self.viewModel?.movie.title
        self.movieDescription.text = self.viewModel?.movie.overview
        self.releaseDate.text = self.viewModel?.movie.releaseDate
        if self.releaseDate.text?.count ?? 0 > 4 {
            self.releaseDate.text?.removeLast(6)
        }
        self.viewModel?.getMoviePoster(callback: { result in
            self.moviePoster.af.setImage(withURL: result)
        })

        buttonClose.addTarget(self, action: #selector(didTapClose(sender:)), for: .touchUpInside)
        moreInformation.addTarget(self, action: #selector(didTapMoreInformation(sender:)), for: .touchUpInside)
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
            make.bottom.equalTo(self.moreInformation.snp.top).offset(-50)
            make.width.equalTo(125)
        }
        
        movieTitle.snp.makeConstraints { make in
            make.left.equalTo(self.moviePoster.snp.right).offset(15)
            make.top.equalTo(self.snp.top).offset(15)
            make.right.equalTo(self.buttonClose.snp.left).offset(-5)
        }
        
        movieDescription.snp.makeConstraints { make in
            make.left.equalTo(self.moviePoster.snp.right).offset(15)
            make.top.equalTo(self.movieTitle.snp.bottom)
            make.right.equalTo(self.buttonClose.snp.left).offset(10)
            make.bottom.equalTo(self.releaseDate.snp.top).offset(-20)
        }
        
        releaseDate.snp.makeConstraints { make in
            make.left.equalTo(self.moviePoster.snp.right).offset(15)
            make.top.equalTo(self.movieDescription.snp.bottom)
            make.bottom.equalTo(moreInformation.snp.bottom).offset(-90)
            make.height.equalTo(20)
            make.width.equalTo(50)
        }
        
        moreInformation.snp.makeConstraints { make in
            make.left.equalTo(self.snp.left).offset(15)
            make.right.equalTo(self.snp.right).offset(-15)
            make.bottom.equalTo(self.snp.bottom).offset(-20)
        }
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
