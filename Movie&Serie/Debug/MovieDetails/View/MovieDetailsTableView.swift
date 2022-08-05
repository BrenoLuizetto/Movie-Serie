//
//  MovieDetailsTableView.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 03/07/22.
//

import Foundation
import UIKit

class MovieDetailsTableView: UITableView {
    
    private var viewModel: MovieDetailsViewModel?
    
    func setiItens(viewModel: MovieDetailsViewModel) {
        self.viewModel = viewModel
        self.viewModel?.setDataSource()
        self.dataSource = self
        self.delegate = self
        setStyle()
        for cell in viewModel.cellData {
            self.register(cell.cellType, forCellReuseIdentifier: cell.reuseIdentifier)
        }
    }
    
    func setStyle() {
        backgroundColor = .black
        separatorStyle = .none
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        
    }
    
    func refreshData(cellData: DetailsCell<Any>?) {
        if let cellData = cellData {
            register(cellData.cellType, forCellReuseIdentifier: cellData.reuseIdentifier)
        }
        reloadWithTransition()
    }
    
}

extension MovieDetailsTableView: UITableViewDataSource,
                                 UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellData = viewModel?.cellData[indexPath.row],
              let cell = tableView.dequeueReusableCell(withIdentifier: cellData.reuseIdentifier,
                                                       for: indexPath)
                as? DetailsViewCell else { return UITableViewCell() }
        cell.setup(data: cellData.data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let dataCount = viewModel?.cellData.count else { return 0 }
        return dataCount
    }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
