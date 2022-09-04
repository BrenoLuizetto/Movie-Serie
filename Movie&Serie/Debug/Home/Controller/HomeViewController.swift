//
//  HomeViewController.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 28/06/21.
//

import Foundation
import UIKit
import SnapKit
import MBProgressHUD
import FirebaseAuth

class HomeViewController: BaseViewController {
    
    private(set) var tableView: HomeTableView?
    private var errorView: ErrorView?
    let refreshControl = UIRefreshControl()
    
    private let viewModel = MovieViewModel()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = .black
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        configNavBar()
        self.tableView = viewModel.tableView
        self.tableView?.buildCell(cellType: .allmovies,
                                  viewModel: self.viewModel,
                                  delegate: MovieCollectionAction(controller: self), {
        })
        self.buildTableView()
        setRefreshControl()
        addObservers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        refreshData()
    }
    
}

extension HomeViewController {
    func configNavBar() {
        self.navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.barStyle = .black
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search,
                                                                 target: self,
                                                                 action: #selector(search))
        let barButton = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal"),
                                        style: .plain,
                                        target: self,
                                        action: #selector(userMenu))
        
        self.navigationItem.leftBarButtonItem = barButton
        self.title = Constants.Labels.appName
    }
    
    private func setRefreshControl() {
        if #available(iOS 10.0, *) {
            tableView?.refreshControl = refreshControl
        } else {
            tableView?.addSubview(refreshControl)
        }
        refreshControl.addTarget(self, action: #selector(refreshWeatherData(_:)), for: .valueChanged)
        
    }
    
    @objc
    private func search() {
        let searchVC = SearchViewController()
        self.navigationController?.pushViewController(searchVC, animated: true)
    }
    
    @objc
    private func userMenu() {
        let menuVC = UserMenuViewController()
        self.navigationController?.pushViewController(menuVC, animated: true)
    }
    
    @objc
    private func refreshWeatherData(_ sender: Any) {
        refreshData()
        self.refreshControl.endRefreshing()
    }
    
    private func refreshData() {
        self.tableView?.refreshData {
            self.view.layoutIfNeeded()
            self.view.removeHUD()
        }
    }
    
    private func showErrorView() {
        self.errorView = ErrorView(callback: {
            self.viewDidLoad()
        })
        self.view.removeConstraints(self.view.constraints)
        self.buildErrorView()
        self.view.removeHUD()
    }
    
    private func addObservers() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didReceiveUpdate),
                                               name: NSNotification.Name(rawValue: "updateFavoriteMovies"),
                                               object: nil)
    }
    
    @objc
    private func didReceiveUpdate() {
        self.refreshData()
    }
}

extension HomeViewController {
    func viewConfig() {
        self.view.backgroundColor = .black
    }
    
    private func buildTableView() {
        tableView?.snp.makeConstraints { make in
            make.top.equalTo(self.view.snp.top).offset(20)
            make.left.equalTo(self.view.snp.left)
            make.right.equalTo(self.view.snp.right)
            make.bottom.equalTo(self.view.snp.bottom)
            
            self.view.addSubview(tableView ?? UITableView())
        }
    }
    
    private func buildErrorView() {
        errorView?.snp.makeConstraints { make in
            make.top.equalTo(self.view.snp.top).offset(20)
            make.left.equalTo(self.view.snp.left).offset(15)
            make.right.equalTo(self.view.snp.right).offset(-15)
            make.bottom.equalTo(self.view.snp.bottom).offset(-15)
            
            self.view.addSubview(errorView ?? UIView())
        }
    }
    
}
