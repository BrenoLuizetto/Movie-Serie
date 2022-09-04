//
//  TopMovieViewCell.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 04/03/22.
//

import UIKit
import SnapKit

class TopMovieViewCell: UITableViewCell {
    private lazy var container: UIView = {
       let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    lazy var moviePoster: UIImageView = {
       let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        imgView.layer.cornerRadius = 5
        return imgView
    }()
    
    lazy var gradientView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
       let lbl = UILabel()
        lbl.font = UIFont(name: Constants.Fonts.kailassaBold, size: 30)
        lbl.textColor = .white
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byTruncatingTail
        lbl.textAlignment = .center
        return lbl
    }()
    
    private lazy var genresContainer: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 20.0
        stack.alignment = .fill
        stack.distribution = .fillProportionally
        return stack
    }()
    
    private lazy var watchButton: UIButton = {
        
        var filled = UIButton.Configuration.filled()
        filled.title = Constants.Labels.watch
        filled.buttonSize = .small
        filled.image = UIImage(systemName: Constants.Images.playFill)
        filled.imagePlacement = .trailing
        filled.imagePadding = 5
        filled.baseBackgroundColor = .white
        filled.baseForegroundColor = .black
        filled.attributedTitle?.font = UIFont(name: Constants.Fonts.avenirHeavy, size: 16)
        let btn = UIButton(configuration: filled, primaryAction: nil)
        btn.addTarget(self, action: #selector(watchMovieAction(sender:)), for: .touchUpInside)
        return btn
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
        btn.addTarget(self, action: #selector(addToMyList(sender:)), for: .touchUpInside)
        return btn
    }()
    
    private lazy var moreInfoButton: UIButton = {
        var filled = UIButton.Configuration.filled()
        filled.title = Constants.Labels.knowMore
        filled.buttonSize = .small
        filled.image = UIImage(systemName: Constants.Images.infoCircle)
        filled.imagePlacement = .top
        filled.imagePadding = 5
        filled.baseBackgroundColor = .clear
        let btn = UIButton(configuration: filled, primaryAction: nil)
        btn.addTarget(self, action: #selector(InfoMoreAction(sender:)), for: .touchUpInside)
        return btn
    }()
    
    private var viewModel: MovieDetailsViewModel?

    func setup(viewModel: MovieDetailsViewModel) {
        self.viewModel = viewModel
        self.titleLabel.text = viewModel.movie.title
        self.setGradientBackground()
        self.setupViewConfiguration()
        self.setGenres()
        self.verifyFavoriteList()
    }

    private func setGradientBackground() {
        let colorTop = UIColor.clear.cgColor
        let colorBottom = UIColor.black.cgColor
                    
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorTop, colorBottom]
        gradientLayer.locations = [0.0, 0.3, 1.0]
        gradientLayer.frame = self.gradientView.bounds
        self.gradientView.layer.sublayers = nil
        self.gradientView.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func setGenres() {
        viewModel?.getDetailsMovie {
            guard let genres = self.viewModel?.movieDetails?.genres else { return }
            self.genresContainer.removeAllViews()
            for genre in genres where self.genresContainer.arrangedSubviews.count < 3 {
                let lbl = UILabel()
                lbl.font = UIFont(name: Constants.Fonts.avenirHeavy, size: 16)
                lbl.textColor = .white
                lbl.text = genre.name
                lbl.lineBreakMode = .byTruncatingTail
                self.genresContainer.addArrangedSubview(lbl)
            }
        }
    }
    
    @objc
    func watchMovieAction(sender: UIButton) {
        self.showHUD()
        viewModel?.getDetailsMovie {
//            self.viewModel?.openMovieStream
            self.removeHUD()
        }
    }
    
    @objc
    func addToMyList(sender: UIButton) {
        viewModel?.addFavorite()
        self.verifyFavoriteList()
        self.viewModel?.DidListChange()
    }
    
    @objc
    func InfoMoreAction(sender: UIButton) {
        guard let movie = viewModel?.movie else { return }
        viewModel?.delegate?.didSelectItem(movie: movie)
    }
    
    private func verifyFavoriteList() {
        if let viewModel = viewModel,
           viewModel.validateFavoriteList() {
            self.favoriteButton.setImage(UIImage(systemName: Constants.Images.checkmark), for: .normal)
        } else {
            self.favoriteButton.setImage(UIImage(systemName: Constants.Images.plus), for: .normal)
        }
    }
}

extension TopMovieViewCell: BuildViewConfiguration {
    func buildViewHierarchy() {
        self.addSubview(container)
        container.addSubview(moviePoster)
        container.addSubview(gradientView)
        container.addSubview(titleLabel)
        container.addSubview(genresContainer)
        container.addSubview(watchButton)
        container.addSubview(moreInfoButton)
        container.addSubview(favoriteButton)

    }
    
    func makeConstraints() {
        container.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        moviePoster.snp.makeConstraints { make in
            make.edges.equalTo(self)
            make.height.equalTo(400)
        }
        
        gradientView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(genresContainer.snp.top).offset(-5)
            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview()
        }
        
        genresContainer.snp.makeConstraints { make in
            make.bottom.equalTo(watchButton.snp.top).offset(-10)
            make.centerX.equalToSuperview()
            
        }
        
        watchButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-40)
            make.centerX.equalToSuperview()
        }
        
        moreInfoButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-15)
            make.left.equalTo(watchButton.snp.right).offset(15)
        }
        
        favoriteButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-15)
            make.right.equalTo(watchButton.snp.left).offset(-15)
        }
    }
    
    func configElements() {
        self.selectionStyle = .none
        self.backgroundColor = .black
    }

}
