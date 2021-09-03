//
//  MovieHeaderSection.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 21/08/21.
//

import Foundation
import UIKit
import SnapKit

class MovieHeaderSection: UITableViewHeaderFooterView {
    
    private lazy var container: UIView = {
       let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    
    init() {
        super.init(reuseIdentifier: "MovieHeaderSection")
        self.addSubview(container)
        
        container.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
