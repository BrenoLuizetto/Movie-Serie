//
//  File.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 26/07/21.
//

import Foundation
import UIKit

class SearchViewController: BaseViewController {
    
    private let viewModel = SearchViewModel()
    
    override func viewDidLoad() {
        let searchView = SearchView(viewModel: viewModel, delegate: MovieCollectionAction(controller: self))
        self.view = searchView
        self.configNavBar()
    }
}

extension SearchViewController {
    private func configNavBar() {
        self.navigationController?.isNavigationBarHidden = false
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: Constants.Labels.back,
                                                                style: .plain,
                                                                target: self, action: #selector(backAction(sender:)))
        
    }
    
    @objc func backAction(sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
}
