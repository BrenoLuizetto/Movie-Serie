//
//  HomeViewController.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 28/06/21.
//

import Foundation
import UIKit
import SnapKit
import Loading

class HomeViewController: UIViewController {
    
    private var tableView: HomeTableView?
    private var errorView: ErrorView?
    private var detailsView: MovieDetailsView?

    private let viewModel = HomeViewModel()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.navigationController?.isNavigationBarHidden = true
        self.view.showLoader()
        self.tableView = viewModel.tableView
        buildTableView()
        getTypes()
        
    }
    
    private func getTypes() {
        viewModel.parametersForCell { parameters in
            if let result = parameters {
                self.tableView?.buildCell(result, viewModel: self.viewModel, delegate: self, {
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
        self.view.removeLoader()
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
    
    func buildDetailsView() {
        detailsView?.snp.makeConstraints { make in
            make.top.equalTo(self.view.snp.top).offset(80)
            make.left.equalTo(self.view.snp.left)
            make.right.equalTo(self.view.snp.right)
            make.bottom.equalTo(self.view.snp.bottom)
            
            self.view.addSubview(detailsView ?? UIView())
        }
    }

}

extension HomeViewController: HomeProtocol {
    func buildConstraints() {
        self.buildTableView()
    }
    
    func finishLoad() {
        self.view.removeLoader()
    }
    
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
    
    func hiddenTabBar(hidden: Bool, animated: Bool) {
        let tabBar = self.tabBarController?.tabBar
        let offset = (hidden ? UIScreen.main.bounds.size.height : UIScreen.main.bounds.size.height - (tabBar?.frame.size.height)! )
        if offset == tabBar?.frame.origin.y {return}
        let duration:TimeInterval = (animated ? 0.5 : 0.0)
        UIView.animate(withDuration: duration,
                       animations: {tabBar!.frame.origin.y = offset},
                       completion:nil)
    }
    
    
    func showDetailsScreen(movie: MovieViewData) {
        let viewModel = MovieDetailsViewModel(movie, with: self)
        let vc = MovieDetailsViewController(viewModel: viewModel)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

