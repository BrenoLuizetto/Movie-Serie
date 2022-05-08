//
//  AboutUsTableView.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 08/02/22.
//

import Foundation
import UIKit

class AboutUsTableView: UITableView {
    
    private var viewModel: AboutUsViewModel?
        
    func registerTableView(with viewModel: AboutUsViewModel) {
        self.viewModel = viewModel
        self.backgroundColor = .black
        self.register(AboutUsViewCell.self, forCellReuseIdentifier: Constants.CellIdentifier.aboutUs)
        self.dataSource = self
        self.delegate = self
    }

}

extension AboutUsTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.cellData.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cellData = self.viewModel?.cellData[indexPath.row],
           let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifier.aboutUs,
                                                    for: indexPath) as? AboutUsViewCell {
            cell.setup(title: cellData.title,
                       state: cellData.state,
                       type: cellData.type)
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel?.cellData[indexPath.row].height ?? UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        toogle(indexPath: indexPath)
    }
    
    private func toogleCell(at indexPath: IndexPath) {
        CATransaction.begin()
        self.beginUpdates()
        CATransaction.setCompletionBlock {
            self.reloadData()
        }
        toogle(indexPath: indexPath)
        self.endUpdates()
        CATransaction.commit()
    }
    
    private func toogle(indexPath: IndexPath) {
        guard let rawCell = viewModel?.cellData[indexPath.row] else { return }
        if rawCell.type == .parent ,
           let cellData = rawCell as? AboutUsParentCellData {
            let indexPaths = getIndexes(parentIndex: indexPath,
                                        numberofChildren: cellData.children.count)
            
            switch cellData.state {
            case .collapsed:
                viewModel?.expanded(indexPaths: indexPaths,
                                    index: indexPath)
                insertRows(at: indexPaths,
                           with: .fade)
        
            case .expanded:
                viewModel?.collapse(indexPaths: indexPaths,
                                    index: indexPath)
                deleteRows(at: indexPaths,
                                with: .fade)
            }
        }
        
    }
    
    private func getIndexes(parentIndex: IndexPath, numberofChildren: Int) -> [IndexPath] {
        return(1...numberofChildren).map { offset -> IndexPath in
            let startPosition: Int = parentIndex.item
            return IndexPath(item: startPosition + offset,
                             section: parentIndex.section)
        }
    }
}
