//
//  SearchView.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 26/07/21.
//

import Foundation
import UIKit
import SnapKit
import MBProgressHUD

enum ContentState {
    case empty
    case search
    case popMovies
}

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
    
    private lazy var contentView: UIView = {
        let view = UIView(frame: .zero)
        return view
    }()
    
    private lazy var layout: UICollectionViewFlowLayout = {
       let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: CGFloat(150), height: CGFloat(280))
        layout.scrollDirection = .vertical

        return layout
    }()
    
    private lazy var emptyView = EmptyView()
    
    lazy var searchCollection = MovieCollectionView(frame: CGRect(), collectionViewLayout: layout)
    
    private var viewModel: SearchViewModel?
    weak var delegate: MovieCollectionProtocol?
    var currentState: ContentState = .popMovies
    
    init(viewModel: SearchViewModel, delegate: MovieCollectionProtocol) {
        self.viewModel = viewModel
        self.delegate = delegate
        super.init(frame: .zero)
        self.showHUD()
        searchCollection.registerCell()
        searchCollection.collectionProtocol = delegate
        self.setContetState(state: .popMovies)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension SearchView: BuildViewConfiguration {
    func buildViewHierarchy() {
        self.addSubview(container)
        container.addSubview(searchBar)
        container.addSubview(contentView)
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
        
        contentView.snp.makeConstraints { make in
            make.left.equalTo(container.snp.left).offset(30)
            make.right.equalTo(container.snp.right).offset(-30)
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
            showHUD()
            self.viewModel?.movieData = []
            self.viewModel?.getSearchMovies(query: formattedString, callback: {(movies, erro) in
                if let moviesArray = movies, !moviesArray.isEmpty {
                    self.searchCollection.setup(movie: moviesArray,
                                                collectionType: .searchMovies,
                                                viewModel: nil)
                    self.searchCollection.reloadMovies()

                    self.setContetState(state: .search)
                } else {
                    self.setContetState(state: .empty)
                }
            })
        } else {
            self.setContetState(state: .popMovies)
        }
    }
}

extension SearchView {
    func setContetState(state: ContentState) {
        
        switch state {
        case .empty:
            if self.currentState != .empty {
                self.currentState = state
                self.searchCollection.setup(movie: [],
                                            collectionType: .searchMovies,
                                            viewModel: nil)
                self.searchCollection.reloadMovies()
                self.contentView = self.emptyView
                self.buildItens()
            }
            self.removeHUD()

   
        case .search:
            if self.currentState != .search {
                self.currentState = state
                self.contentView = self.searchCollection
                self.buildItens()
            }
            self.removeHUD()

        case .popMovies:
            self.searchCollection.movie = []
            self.viewModel?.getPopularMovies(callback: { result, error in
                if let movie = result {
                    self.searchCollection.setup(movie: movie,
                                                collectionType: .searchMovies,
                                                viewModel: nil)
                    self.searchCollection.reloadMovies()
                    self.contentView = self.searchCollection
                    self.buildItens()
                    self.removeHUD()
                }
            })
            break
        }
    }
}
