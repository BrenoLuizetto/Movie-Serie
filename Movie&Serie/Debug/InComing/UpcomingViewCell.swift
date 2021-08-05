//
//  SearchViewCell.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 02/08/21.
//

import Foundation
import UIKit
import SnapKit

class UpcomingViewCell: UITableViewCell {
    
    private lazy var container: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var detailsContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var movieBackground: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.layer.cornerRadius = 5
        img.layer.masksToBounds = true
        return img
    }()
    
    private lazy var movieTitle: UILabel = {
       let lbl = UILabel()
        lbl.textColor = .white
        lbl.font = UIFont(name: HomeConstats.Fonts.kailassaBold, size: 30)
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private lazy var releaseDate: UILabel = {
        let lbl = UILabel()
         lbl.textColor = .white
         lbl.font = UIFont(name: HomeConstats.Fonts.avenirMedium, size: 18)
         lbl.numberOfLines = 0
         return lbl
    }()
    
    private lazy var movieDescription: UILabel = {
        let lbl = UILabel()
         lbl.textColor = .lightText
        lbl.font = UIFont(name: HomeConstats.Fonts.avenirBook, size: 18)
         lbl.numberOfLines = 0
         return lbl
    }()

    private lazy var genre: UILabel = {
        let lbl = UILabel()
         lbl.textColor = .white
         lbl.font = UIFont(name: HomeConstats.Fonts.kailassaBold, size: 18)
         lbl.numberOfLines = 0
         return lbl
    }()
    
    func buildParameters(movie: MovieViewData) {
        self.backgroundColor = .black
        self.movieTitle.text = movie.title
        self.releaseDate.text = buildReleaseDate(with: movie.releaseDate)
        self.movieDescription.text = movie.overview
        self.buildItems()
    }
    
    private func buildReleaseDate(with datevalue: String) -> String {
        var auxString = datevalue.replacingOccurrences(of: "-", with: "")
        let year = auxString.prefix(4)
        let removeYear = auxString.startIndex..<auxString.index(auxString.startIndex, offsetBy: 3)
        auxString.removeSubrange(removeYear)
        let month = auxString.prefix(2)
        let removeMonth = auxString.startIndex..<auxString.index(auxString.startIndex, offsetBy: 1)
        auxString.removeSubrange(removeMonth)
        let day = auxString.prefix(2)
        
        return String("Lançamento: " + day + "/" + month + "/" + year)
    }
}

extension UpcomingViewCell: BuildViewConfiguration {
    
    func buildViewHierarchy() {
        self.addSubview(container)
        container.addSubview(movieBackground)
        container.addSubview(detailsContainer)
        detailsContainer.addSubview(movieTitle)
        detailsContainer.addSubview(releaseDate)
        detailsContainer.addSubview(movieDescription)
        detailsContainer.addSubview(genre)
    }
    
    func makeConstraints() {
        container.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        movieBackground.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.container.snp.top)
            make.height.equalTo(250)
        }
        
        detailsContainer.snp.makeConstraints { make in
            make.top.equalTo(movieBackground.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
        movieTitle.snp.makeConstraints { make in
            make.left.equalTo(detailsContainer.snp.left).offset(15)
            make.top.equalTo(movieBackground.snp.bottom).offset(5)
            make.right.equalTo(detailsContainer.snp.right).offset(-15)
        }
        
        releaseDate.snp.makeConstraints { make in
            make.left.equalTo(detailsContainer.snp.left).offset(15)
            make.top.equalTo(movieTitle.snp.bottom).offset(15)
            make.right.equalTo(detailsContainer.snp.right).offset(-15)

        }
        
        movieDescription.snp.makeConstraints { make in
            make.left.equalTo(detailsContainer.snp.left).offset(15)
            make.top.equalTo(releaseDate.snp.bottom).offset(5)
            make.right.equalTo(detailsContainer.snp.right).offset(-15)
            make.bottom.equalTo(detailsContainer.snp.bottom).offset(-5)
        }
        
//        genre.snp.makeConstraints { make in
//            make.left.equalTo(detailsContainer.snp.left).offset(15)
//            make.top.equalTo(releaseDate.snp.bottom).offset(5)
//            make.bottom.equalTo(detailsContainer.snp.bottom)
//        }
    }
    
    func configElements() {
        //not implemented
    }
}