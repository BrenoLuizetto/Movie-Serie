//
//  HomeCollectionViewCell.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 01/07/21.
//

import Foundation
import UIKit
import SnapKit

class HomeCollectionViewCell: UICollectionViewCell {
    private lazy var container: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.5)
        return view
    }()
    
    lazy var moviePoster: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.layer.cornerRadius = 5
        return image
    }()
    
    func setup() {
        self.layoutIfNeeded()
        buildItens()
    }
    
}

extension HomeCollectionViewCell: BuildViewConfiguration {
    func buildViewHierarchy() {
        self.addSubview(container)
        self.container.addSubview(self.moviePoster)
        
    }

    func configElements() {}

    func makeConstraints() {
        
        container.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        moviePoster.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalToSuperview().offset(5)
            make.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-5)
        }
    }
}
