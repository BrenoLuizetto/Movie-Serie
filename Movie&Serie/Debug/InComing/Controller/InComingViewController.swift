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
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        self.view = tableView
        parametersForTable()
        configNavBar()
        setRefreshControl()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.view.showHUD()
        self.tableView.getMovie {
            self.view.removeHUD()
        }
    }
    
    func parametersForTable() {
        let types: [MovieSettings] = [MovieSettings(typeMovie: Constants.MovieType.upcoming,
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
    
    private func setRefreshControl() {
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        refreshControl.addTarget(self, action: #selector(refreshWeatherData(_:)), for: .valueChanged)

    }
    
    
    @objc
    private func refreshWeatherData(_ sender: Any) {
        self.view.showHUD()
        self.tableView.getMovie {
            self.refreshControl.endRefreshing()
            self.view.removeHUD()
        }
    }
    
    @objc private func search(sender: UIButton) {
        let searchVC = SearchViewController()
        self.navigationController?.pushViewController(searchVC, animated: true)
    }
}
