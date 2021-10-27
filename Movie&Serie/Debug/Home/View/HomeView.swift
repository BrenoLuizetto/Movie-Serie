//
//  HomeView.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 28/06/21.
//

import Foundation
import UIKit
import SnapKit

class HomeView: UIView {
    
    private lazy var container: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    private lazy var title: UILabel = {
        let title = UILabel()
        title.font = UIFont(name: "Rockwell-Bold", size: 20)
        title.text = "Amazflix"
        title.textAlignment = .center
        title.textColor = .white
        return title
    }()
    
    init() {
        super.init(frame: CGRect())
        buildItens()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension HomeView : BuildViewConfiguration {
    func buildViewHierarchy() {
        self.addSubview(self.title)
    }

    func configElements() {
       //Not Implemented
    }

    func makeConstraints() {

        title.snp.makeConstraints { make in
            make.left.equalTo(self.snp.left).offset(15)
            make.top.equalTo(self.snp.top).offset(5)
            make.right.equalTo(self.snp.right).offset(-15)
            make.height.equalTo(20)
        }
    }
}
