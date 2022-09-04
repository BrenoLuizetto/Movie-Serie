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
        configNavBar()
        setupViewConfiguration()
        bindViewModel()
        setupTableView()
    }

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
            self.tableView.register(cellData: data ?? nil)
            self.tableView.reloadWithTransition()
        }
        
        viewModel.showHUD = {
            self.view.showHUD()
        }
        
        viewModel.hideHUD = {
            self.view.removeHUD()
        }
    }
    
    private func setupTableView() {
        viewModel.setDataSource(infoContainerProtocol: self)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadWithTransition()
    }
}

extension MovieDetailsViewController: InfoContainerProtocol {
    func didTapWatch() {
        view.showHUD()
        viewModel.getDetailsMovie {
            self.viewModel.openMovieStream(controller: self)
            self.view.removeHUD()
        }
    }
    
    func didTapFavorite(callback: ((Bool) -> Void)) {
        viewModel.addFavorite()
        callback(viewModel.validateFavoriteList())
    }
}

extension MovieDetailsViewController: UITableViewDataSource,
                                      UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellData = viewModel.cellData[indexPath.row]
        self.tableView.register(cellData: cellData)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellData.reuseIdentifier,
                                                       for: indexPath)
                as? DetailsViewCell else { return UITableViewCell() }
        
        cell.setup(data: cellData.data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cellData.count
    }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
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
