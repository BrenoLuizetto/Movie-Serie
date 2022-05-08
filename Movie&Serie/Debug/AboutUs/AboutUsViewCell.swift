//
//  AboutUsViewCell.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 08/02/22.
//

import Foundation
import UIKit
import SnapKit

class AboutUsViewCell: UITableViewCell {
    
    private lazy var container: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    private lazy var icon: UIButton = {
        let btn = UIButton()
        btn.tintColor = .white
        return btn
    }()
    
    private lazy var titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: Constants.Fonts.kailassaBold, size: 16)
        lbl.textColor = .white
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byTruncatingTail
        return lbl
    }()
    
    var type: AboutUsCellType = .parent
    
    func setup(title: String,
               state: AboutUsCellState,
               type: AboutUsCellType) {
        self.titleLbl.text = title
        self.type = type
        switch state {
        case .collapsed:
            icon.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        case .expanded:
            icon.setImage(UIImage(systemName: "chevron.up"), for: .normal)
        }
        
        self.buildItens()
    }
}

extension AboutUsViewCell: BuildViewConfiguration {
    func buildViewHierarchy() {
        self.removeAllViews()
        self.addSubview(container)
        self.addSubview(titleLbl)
        if type == .parent {
            self.addSubview(icon)
        }
    }
    
    func makeConstraints() {
        container.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        switch type {
        case .parent:
            icon.snp.makeConstraints { make in
                make.left.equalTo(16)
                make.centerY.equalToSuperview()
                make.height.equalTo(20)
                make.width.equalTo(20)
            }
            
            titleLbl.snp.makeConstraints { make in
                make.left.equalTo(icon.snp.right).offset(16)
                make.right.equalToSuperview().offset(-16)
                make.centerY.equalToSuperview()
            }
        case .child:
            titleLbl.snp.makeConstraints { make in
                make.left.equalTo(container.snp.left).offset(16)
                make.right.equalToSuperview().offset(-16)
                make.top.equalTo(container.snp.top).offset(16)
            }
        }
        
        
        
    }
    
    func configElements() {
        
    }
}
