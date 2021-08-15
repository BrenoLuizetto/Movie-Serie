//
//  InComingViewController.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 30/07/21.
//

import Foundation
import UIKit
import SnapKit

class InComingViewController: UIViewController {
    
    private let viewModel = MovieViewModel()
    private let tableView = HomeTableView()
    
    override func viewWillAppear(_ animated: Bool) {
        self.view = tableView
        parametersForTable()
    }
    
    func parametersForTable() {
        let types: [MovieType] = [MovieType(typeMovie: HomeConstats.movieType.upcoming,
                                            titleOfCell: HomeConstats.cellTitle.upcoming,
                                            genreType: nil)]
        self.tableView.buildCell(cellType: .upcoming, types, viewModel: self.viewModel, delegate: MovieCollectionAction(controller: self)) {

        }
    }

}
