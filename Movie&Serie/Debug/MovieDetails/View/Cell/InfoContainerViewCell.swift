//
//  InfoContainerView.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 01/07/22.
//

import Foundation
import UIKit
import SnapKit

protocol InfoContainerProtocol: AnyObject {
    func didTapWatch()
    func didTapFavorite(callback: ((Bool) -> Void))
}

struct InfoCellData {
    let title: String
    let rating: String
    let release: String
    let description: String
    let isFavorite: Bool
    var delegate: InfoContainerProtocol
}

final class InfoContainerViewCell: DetailsViewCell {
    
    private lazy var container: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
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
        lbl.text = "aaaaaaaaa"
        return lbl
    }()
    
    lazy var genresContainer: UIStackView = {
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
    
    var hasGenre: Bool = false
    private weak var delegate: InfoContainerProtocol?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style,
                   reuseIdentifier: reuseIdentifier)
        setupViewConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setup<T>(data: T) {
        guard let infoCellData = data as? InfoCellData else { return }
        setItens(title: infoCellData.title,
                 rating: infoCellData.rating,
                 release: infoCellData.release,
                 description: infoCellData.description,
                 isFavorite: infoCellData.isFavorite)
        self.delegate = infoCellData.delegate
    }
    
    func setFavoriteImage(isFavorite: Bool) {
        let image = isFavorite ? Constants.Images.checkmark : Constants.Images.plus
        favoriteButton.setImage(UIImage(systemName: image), for: .normal)
    }
    
    func setItens(title: String,
                  rating: String,
                  release: String,
                  description: String,
                  isFavorite: Bool) {
        self.movieTitle.text = title
        self.movieRating.text = rating
        self.releaseDate.text = release
        self.movieDescription.text = description
        setFavoriteImage(isFavorite: isFavorite)
        removeAllShimer()
    }
    
    func separatorIsHidden(_ value: Bool) {
        separator.isHidden = value
    }

    @objc
    private func addFavorite(sender: UIButton) {
        self.delegate?.didTapFavorite(callback: { isFavorite in
            self.setFavoriteImage(isFavorite: isFavorite)
        })
    }
    
    @objc
    private func streamMovie(sender: UIButton) {
        self.delegate?.didTapWatch()
    }
    
    func removeAllShimer() {
        DispatchQueue.main.async {
            self.movieDescription.removeShimmer()
            self.releaseDate.removeShimmer()
        }
    }
    
}

extension InfoContainerViewCell: BuildViewConfiguration {
    func buildViewHierarchy() {
        
        self.contentView.addSubview(container)
        self.container.addSubview(movieTitle)
        self.container.addSubview(movieRating)
        self.container.addSubview(releaseDate)
        self.container.addSubview(movieDescription)
        self.container.addSubview(genresContainer)
        self.container.addSubview(buttonsContainer)
        self.buttonsContainer.addArrangedSubview(favoriteButton)
        self.buttonsContainer.addArrangedSubview(playButton)
        self.container.addSubview(separator)
    }
    
    func makeConstraints() {
        container.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        movieTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
        }
        
        movieRating.snp.makeConstraints { make in
            make.top.equalTo(self.movieTitle.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(15)
            make.right.equalTo(releaseDate.snp.left).offset(-10)
        }
        
        releaseDate.snp.makeConstraints { make in
            make.top.equalTo(self.movieTitle.snp.bottom).offset(5)
            make.left.equalTo(movieRating.snp.right).offset(10)
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
            make.right.equalTo(container.snp.right).offset(-16)
            make.top.equalTo(favoriteButton.snp.bottom).offset(40)
            make.height.equalTo(1)
            make.bottom.equalToSuperview()
        }
    }
    
    func configElements() {
        self.backgroundColor = .clear
        self.selectionStyle = .none
        
        DispatchQueue.main.async {
            self.movieDescription.startAnimatingShimmer()
            self.releaseDate.startAnimatingShimmer()
        }
    }
}
