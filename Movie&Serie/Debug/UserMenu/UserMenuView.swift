//
//  UserMenuView.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 20/12/21.
//

import Foundation
import UIKit

class UserMenuView: UIView {
    
    private lazy var container: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    private lazy var perfilImage: UIImageView = {
        let img = UIImageView(image: UIImage(named: "perfilTest"))
        return img
    }()
    
    private lazy var usernameLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: Constants.Fonts.kailassaBold, size: 16)
        lbl.textColor = .white
        lbl.text = "username"
        lbl.textAlignment = .center
        return lbl
    }()
    
    private lazy var mailLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: Constants.Fonts.kailassaBold, size: 16)
        lbl.textColor = .white
        lbl.text = "email"
        lbl.textAlignment = .center
        return lbl
    }()
    
    private lazy var userTableView: UserMenuTableView = {
        let table = UserMenuTableView(frame: .zero)
        table.backgroundColor = .black
        return table
    }()
    
    private var viewModel: UserMenuViewModel?
    private weak var delegate: UserMenuDelegate?
    
    init(viewModel: UserMenuViewModel,
         delegate: UserMenuDelegate) {
        
        self.viewModel = viewModel
        self.delegate = delegate
        
        super.init(frame: .zero)
        
        self.buildItens()
        self.userTableView.registerCell()
        self.userTableView.cellDelegate = delegate
        self.setText()
        self.viewModel?.getMenuItens(callback: { result in
            self.userTableView.setDataSource(menuItem: result)
        })
    }
    
    private func setText() {
        self.usernameLabel.text = viewModel?.userLogado?.displayName
        self.mailLabel.text = viewModel?.userLogado?.email
    }
                              
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UserMenuView: BuildViewConfiguration {
    func buildViewHierarchy() {
        self.addSubview(container)
        self.addSubview(perfilImage)
        self.addSubview(usernameLabel)
        self.addSubview(mailLabel)
        self.addSubview(userTableView)
    }

    func makeConstraints() {
        container.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview()
            make.top.equalToSuperview().offset(80)
        }
        
        perfilImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(container).offset(16)
            make.width.equalTo(100)
            make.height.equalTo(100)
            
            perfilImage.setRounded()
        }
        
        usernameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(perfilImage.snp.bottom).offset(16)
            make.left.right.equalTo(container)
        }
        
        mailLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(usernameLabel.snp.bottom).offset(10)
            make.left.right.equalTo(container)
        }
        
        userTableView.snp.makeConstraints { make in
            make.top.equalTo(mailLabel.snp.bottom).offset(16)
            make.left.right.bottom.equalToSuperview()
        }
    }

    func configElements() {
        
    }
}
