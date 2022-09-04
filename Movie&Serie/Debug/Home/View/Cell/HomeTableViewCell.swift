//
//  HomeView.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 28/06/21.
//

import Foundation
import UIKit
import SnapKit

class HomeTableViewCell: UITableViewCell {
    
    private lazy var container: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    private lazy var title: UILabel = {
        let title = UILabel()
        title.font = UIFont(name: Constants.Fonts.kailassaBold, size: 20)
        title.textAlignment = .left
        title.textColor = .white
        return title
    }()
    
    private lazy var layout: UICollectionViewFlowLayout = {
       let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: CGFloat(150), height: CGFloat(250))
        layout.scrollDirection = .horizontal

        return layout
    }()
    
    lazy var movieCollection = MovieCollectionView(frame: CGRect(), collectionViewLayout: layout)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = UITableViewCell.SelectionStyle.none
        setupViewConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getProperties(sectionTitle: String,
                       movie: [MovieViewData],
                       section: Int,
                       delegate: MovieCollectionProtocol?) {
        movieCollection.tag = section
        movieCollection.accessibilityScroll(.right)
        movieCollection.registerCell()
        movieCollection.setup(movie: movie)
        movieCollection.collectionProtocol = delegate
        
        self.title.text = sectionTitle
        self.backgroundColor = .black
        setupViewConfiguration()
        
    }    
}

extension HomeTableViewCell: BuildViewConfiguration {
    func buildViewHierarchy() {
        self.contentView.addSubview(container)
        self.container.addSubview(self.title)
        self.container.addSubview(self.movieCollection)
    }

    func configElements() {
        
    }

    func makeConstraints() {
        container.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        title.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.top.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-15)
        }
        
        movieCollection.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(self.title.snp.bottom).offset(5)
            make.height.equalTo(250)
        }
    }
    
}
