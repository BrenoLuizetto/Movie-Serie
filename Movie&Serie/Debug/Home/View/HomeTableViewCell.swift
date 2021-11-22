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
        buildItens()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getProperties(sectionTitle: String,
                       movie: [MovieViewData],
                       section: Int,
                       delegate: MovieCollectionProtocol?) {
        movieCollection.tag = section
        movieCollection.registerCell()
        movieCollection.setup(movie: movie, collectionType: .homeMovies, viewModel: nil)
        movieCollection.collectionProtocol = delegate
        
        self.title.text = sectionTitle
        self.backgroundColor = .black
        buildItens()
        
    }    
}

extension HomeTableViewCell: BuildViewConfiguration {
    func buildViewHierarchy() {
        self.addSubview(self.title)
        self.addSubview(self.movieCollection)
    }

    func configElements() {
        
    }

    func makeConstraints() {
        title.snp.makeConstraints { make in
            make.left.equalTo(self.snp.left).offset(15)
            make.top.equalTo(self.snp.top).offset(10)
            make.right.equalTo(self.snp.right).offset(-15)
        }
        
        movieCollection.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(self.title.snp.bottom).offset(5)
        }
    }
    
}
