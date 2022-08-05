//
//  MovieDetailsViewController.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 10/07/21.
//

import Foundation
import UIKit
import MBProgressHUD

class MovieDetailsViewController: BaseViewController {
    
    private var viewModel: MovieDetailsViewModel
    private var movieDetailsView: MovieDetailsView?
    private var tableView = MovieDetailsTableView()
    
    init(viewModel: MovieDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {

    }
    
    override func viewDidLoad() {
        self.configNavBar()
        self.setupViewConfiguration()
        self.bindViewModel()
        self.tableView.setiItens(viewModel: viewModel)
        self.tableView.reloadData()
    }
    
//    override func loadView() {
//        movieDetailsView = MovieDetailsView(self.viewModel, delegate: MovieCollectionAction(controller: self))
//        self.view = movieDetailsView
//        movieDetailsView?.setScrollView()
//    }

}

extension MovieDetailsViewController {
    private func configNavBar() {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Voltar",
                                                                style: .plain,
                                                                target: self,
                                                                action: #selector(backAction(sender:)))
    }
    
    @objc
    func backAction(sender: UIBarButtonItem) {
    navigationController?.popViewController(animated: true)
    }
    
    private func bindViewModel() {
        viewModel.refreshView = { data in
            self.tableView.refreshData(cellData: data ?? nil)
        }
        
        viewModel.showHUD = {
            self.view.showHUD()
        }
        
        viewModel.hideHUD = {
            self.view.removeHUD()
        }
    }
}

extension MovieDetailsViewController: BuildViewConfiguration {
    func buildViewHierarchy() {
        self.view.addSubview(tableView)
    }
    
    func makeConstraints() {
        tableView.snp.makeConstraints({ make in
            make.edges.equalToSuperview()
        })
    }
    
    
}
