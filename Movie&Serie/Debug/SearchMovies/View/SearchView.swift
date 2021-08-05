//
//  SearchView.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 26/07/21.
//

import Foundation
import UIKit
import SnapKit

class SearchView: UIView {
    
    private lazy var container: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    private lazy var searchBar: UISearchBar = {
        let search = UISearchBar()
        search.barStyle = .black
        search.isUserInteractionEnabled = true
        search.backgroundColor = .clear
        search.placeholder = "Oque você procura"
        search.isTranslucent = true
        search.searchBarStyle = .minimal
        search.delegate = self
        return search
    }()
    
    private lazy var layout: UICollectionViewFlowLayout = {
       let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: CGFloat(150), height: CGFloat(280))
        layout.scrollDirection = .vertical

        return layout
    }()
    
    private lazy var errorView: UIView = {
        let view = ErrorView {
            
        }
        return view
    }()
    
    lazy var searchCollection = HomeCollectionView(frame: CGRect(), collectionViewLayout: layout)
    
    private var viewModel: SearchViewModel?
    weak var delegate: MovieCollectionProtocol?
    
    init(viewModel: SearchViewModel, delegate: MovieCollectionProtocol) {
        self.viewModel = viewModel
        self.delegate = delegate
        super.init(frame: .zero)
        
        searchCollection.registerCell()
        searchCollection.collectionProtocol = delegate
        errorView.isHidden = true
        buildItems()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}



extension SearchView: BuildViewConfiguration {
    func buildViewHierarchy() {
        self.addSubview(container)
        container.addSubview(searchBar)
        container.addSubview(searchCollection)
        container.addSubview(errorView)

    }
    
    func makeConstraints() {
        container.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalToSuperview().offset(80)
        }
        
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(self.container.snp.top).offset(20)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(50)
        }
        
        searchCollection.snp.makeConstraints { make in
            make.left.equalTo(container.snp.left).offset(30)
            make.right.equalTo(container.snp.right).offset(-30)
            make.top.equalTo(searchBar.snp.bottom).offset(5)
            make.bottom.equalTo(container.snp.bottom).offset(-15)
        }
        
        errorView.snp.makeConstraints { make in
            make.left.equalTo(container.snp.left).offset(15)
            make.right.equalTo(container.snp.right).offset(-15)
            make.top.equalTo(searchBar.snp.bottom).offset(5)
            make.bottom.equalTo(container.snp.bottom).offset(-15)
        }

    }
    
    func configElements() {
        searchCollection.collectionProtocol = delegate
    }
    
    
}

extension SearchView: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {

    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
            let formattedString = searchText.replacingOccurrences(of: " ", with: "", options: .regularExpression)
            self.viewModel?.getSearchMovies(query: formattedString, callback: { movies, erro  in
                if let moviesArray = movies {
                    self.searchCollection.movie = moviesArray
                    self.searchCollection.reloadMovies()
                }
            })
        } else {
            self.searchCollection.movie = []
            self.searchCollection.reloadMovies()
        }
    }
}
