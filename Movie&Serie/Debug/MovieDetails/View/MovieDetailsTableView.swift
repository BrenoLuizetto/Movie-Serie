//
//  MovieDetailsTableView.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 03/07/22.
//

import Foundation
import UIKit

class MovieDetailsTableView: UITableView {
    
    override init(frame: CGRect,
                  style: UITableView.Style) {
        super.init(frame: frame,
                   style: style)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        setStyle()
    }
    
    func setStyle() {
        backgroundColor = .black
        separatorStyle = .none
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
    }
    
    func register(cellData: DetailsCell<Any>?) {
        if let cellData = cellData {
            register(cellData.cellType, forCellReuseIdentifier: cellData.reuseIdentifier)
        }
    }
    
}
