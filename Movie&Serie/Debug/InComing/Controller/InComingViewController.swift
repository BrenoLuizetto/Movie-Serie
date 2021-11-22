//
//  InComingViewController.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 30/07/21.
//

import Foundation
import UIKit
import SnapKit

class InComingViewController: BaseViewController {
    
    private let viewModel = MovieViewModel()
    private let tableView = HomeTableView()
    
    override func viewWillAppear(_ animated: Bool) {
        self.view = tableView
        parametersForTable()
        configNavBar()
    }
    
    func parametersForTable() {
        let types: [MovieType] = [MovieType(typeMovie: Constants.MovieType.upcoming,
                                            titleOfCell: Constants.CellTitle.upcoming,
                                            genreType: nil)]
        self.tableView.buildCell(cellType: .upcoming,
                                 types,
                                 viewModel: self.viewModel,
                                 delegate: MovieCollectionAction(controller: self)) {

        }
    }
    
    func configNavBar() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search,
                                                                 target: self,
                                                                 action: #selector(search(sender:)))

    }

    @objc private func search(sender: UIButton) {
        let searchVC = SearchViewController()
        self.navigationController?.pushViewController(searchVC, animated: true)
    }
}
