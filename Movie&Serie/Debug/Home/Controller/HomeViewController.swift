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

class HomeViewController: UIViewController {
    
    private var tableView: HomeTableView?
    private var errorView: ErrorView?
    private var detailsView: MovieDetailsView?

    private let viewModel = MovieViewModel()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = .black
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.view.showHUD()
        self.tableView = viewModel.tableView
        configNavBar()
         getTypes()
    }
}

extension HomeViewController {
    func configNavBar() {
        self.navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        
        self.navigationController?.isNavigationBarHidden = false
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search,
                                                                 target: self,
                                                                 action: #selector(search(sender:)))
    }
    
    @objc private func search(sender: UIButton) {
        let searchVC = SearchViewController()
        self.navigationController?.pushViewController(searchVC, animated: true)
    }
    
    private func getTypes() {
        viewModel.parametersForCell { parameters in
            if let result = parameters {
                self.tableView?.buildCell(cellType: .AllMovies, result, viewModel: self.viewModel, delegate: MovieCollectionAction(controller: self), {
                    self.buildTableView()
                    self.view.removeHUD()
                })
            } else {
                self.showErrorView()
            }

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

}

extension HomeViewController {
    func viewConfig() {
        self.view.backgroundColor = .black
    }
    
    func buildTableView() {
        tableView?.snp.makeConstraints { make in
            make.top.equalTo(self.view.snp.top).offset(20)
            make.left.equalTo(self.view.snp.left)
            make.right.equalTo(self.view.snp.right)
            make.bottom.equalTo(self.view.snp.bottom).offset(-15)
            
            self.view.addSubview(tableView ?? UITableView())
        }
    }
    
    func buildErrorView() {
        errorView?.snp.makeConstraints { make in
            make.top.equalTo(self.view.snp.top).offset(20)
            make.left.equalTo(self.view.snp.left).offset(15)
            make.right.equalTo(self.view.snp.right).offset(-15)
            make.bottom.equalTo(self.view.snp.bottom).offset(-15)
            
            self.view.addSubview(errorView ?? UIView())
        }
    }

}

