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
        return image
    }()
    
    func setup() {
        buildItems()
    }
    
}

extension HomeCollectionViewCell : BuildViewConfiguration {
    func buildViewHierarchy() {
        self.addSubview(self.moviePoster)
        
    }

    func configElements() {}

    func makeConstraints() {
        
        moviePoster.snp.makeConstraints { make in
            make.left.equalTo(self.snp.left)
            make.top.equalTo(self.snp.top).offset(5)
            make.right.equalTo(self.snp.right)
            make.bottom.equalTo(self.snp.bottom).offset(-5)
        }
    }
}
