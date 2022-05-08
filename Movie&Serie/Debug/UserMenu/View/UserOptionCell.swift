//
//  UserOptionCell.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 20/12/21.
//

import Foundation
import UIKit

class UserOptionViewCell: UITableViewCell {
    
    private lazy var container: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .black
        return view
    }()
    
    private lazy var icon: UIImageView = {
        let img = UIImageView()
        img.sizeToFit()
        img.contentMode = .scaleAspectFill
        img.tintColor = .white
        return img
    }()
    
    private lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: Constants.Fonts.kailassaBold, size: 12)
        lbl.textColor = .white
        return lbl
    }()
    
    func setupCell(title: String, icon: String) {
        buildItens()
        self.titleLabel.text = title
        self.icon.image = UIImage(systemName: icon)
    }
}

extension UserOptionViewCell: BuildViewConfiguration {
    func buildViewHierarchy() {
        self.addSubview(container)
        self.addSubview(icon)
        self.addSubview(titleLabel)
    }
    
    func makeConstraints() {
        container.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        icon.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(icon.snp.right).offset(16)
            make.centerY.equalToSuperview()
        }
    }
    
    func configElements() {
        
    }
}
