//
//  File.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 26/07/21.
//

import Foundation
import UIKit

class SearchViewController: UIViewController {
    
    private let viewModel = SearchViewModel()
    
    override func viewDidLoad() {
        let searchView = SearchView(viewModel: viewModel, delegate: self)
        self.view = searchView
        self.configNavBar()
    }
}

extension SearchViewController {
    private func configNavBar() {
        self.navigationController?.isNavigationBarHidden = false
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: HomeConstats.labels.back, style: .plain, target: self, action: #selector(backAction(sender:)))
        
    }
    
    @objc func backAction(sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
}

extension SearchViewController: MovieCollectionProtocol {
    func didSelectItem(movie: MovieViewData) {
        let viewModel = MovieDetailsViewModel(movie, with: self)
        let vc = MovieModalViewController(viewModel: viewModel)
        let detailsTransitioningDelegate = InteractiveModalTransitioningDelegate(from: self, to: vc)
        
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = detailsTransitioningDelegate
        vc.definesPresentationContext = true
        
        self.hiddenTabBar(hidden: true, animated: true)
        self.present(vc, animated: true, completion: nil)
        self.view.removeLoader()
    }
    
    func finishLoad() {
        self.view.removeLoader()
    }
    
    
    func hiddenTabBar(hidden: Bool, animated: Bool) {
        //not implemented
    }
    
    func showDetailsScreen(movie: MovieViewData) {
        let viewModel = MovieDetailsViewModel(movie, with: self)
        let vc = MovieDetailsViewController(viewModel: viewModel)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
