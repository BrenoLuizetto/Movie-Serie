//
//  RecommendationViewCell.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 02/08/22.
//

import Foundation
import UIKit

class RecommendationViewCell: DetailsViewCell {
    
    private let defaultHeight: CGFloat = 250
    
    private lazy var recommendationTitle: UILabel = {
       let lbl = UILabel()
        lbl.text = Constants.Labels.recommendations
        lbl.font = UIFont(name: Constants.Fonts.avenirHeavy, size: 18)
        lbl.textColor = .white
        lbl.textAlignment = .left
        
        return lbl
    }()
    
    private lazy var layout: UICollectionViewFlowLayout = {
       let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: CGFloat(150), height: CGFloat(defaultHeight))
        layout.scrollDirection = .horizontal

        return layout
    }()
    
    var viewData: RecommendatioViewData?
    
    override func setup<T>(data: T) {
        self.viewData = data as? RecommendatioViewData
        setupViewConfiguration()
        configRecommendationCollection()
    }
    
    lazy var recommendationCollection = MovieCollectionView(frame: CGRect(), collectionViewLayout: layout)
    
    private func configRecommendationCollection() {
        self.recommendationCollection.registerCell()
        self.recommendationCollection.collectionProtocol = viewData?.collectionProtocol
        self.recommendationCollection.setupReccomedation(movies: viewData?.movies ?? [])
    }
}

extension RecommendationViewCell: BuildViewConfiguration {
    func buildViewHierarchy() {
        self.contentView.addSubview(recommendationTitle)
        self.contentView.addSubview(recommendationCollection)
    }
    
    func makeConstraints() {
        recommendationTitle.snp.makeConstraints { make in
            make.left.top.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        recommendationCollection.snp.makeConstraints { make in
            make.top.equalTo(recommendationTitle.snp.bottom).offset(16)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-16)
            make.height.equalTo(defaultHeight)
        }
    }
    
    func configElements() {
        self.backgroundColor = .clear
    }
    
}
