//
//  AboutUsViewController.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 08/02/22.
//

import Foundation
import UIKit
import SnapKit

class AboutUsViewController: UIViewController {
    
    var tableView: AboutUsTableView = AboutUsTableView()
    let viewModel: AboutUsViewModel = AboutUsViewModel()
    
    override func viewDidLoad() {
        setupViewConfiguration()
        tableView.registerTableView(with: viewModel)
        tableView.reloadData()
    }
}

extension AboutUsViewController: BuildViewConfiguration {
    func buildViewHierarchy() {
        self.view.addSubview(tableView)
    }
    
    func makeConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configElements() {
        // Not implemented
    }
}
