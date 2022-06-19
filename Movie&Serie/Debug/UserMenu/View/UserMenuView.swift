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
        let img = UIImageView()
        img.layer.borderWidth = 1.0
        img.layer.masksToBounds = false
        img.clipsToBounds = true
        img.contentMode = .scaleAspectFill
        img.layer.cornerRadius = 75
        return img
    }()
    
    private lazy var usernameLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: Constants.Fonts.kailassaBold, size: 16)
        lbl.textColor = .white
        lbl.text = Constants.Labels.username
        lbl.textAlignment = .center
        return lbl
    }()
    
    private lazy var mailLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: Constants.Fonts.kailassaBold, size: 16)
        lbl.textColor = .white
        lbl.text = Constants.Labels.mail
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
        userTableView.registerCell()
        userTableView.cellDelegate = delegate
        setText()
        setProfileImage()
        self.viewModel?.getMenuItens(callback: { result in
            self.userTableView.setDataSource(menuItem: result)
        })
    }
    
    private func setProfileImage() {
        if let profileImage = viewModel?.getProfilePicture() {
            self.perfilImage.image = profileImage
        } else if let userPhoto = viewModel?.userShared.userLogado?.photoURL {
            self.perfilImage.af.setImage(withURL: userPhoto)
        }
    }
    
    private func setText() {
        self.usernameLabel.text = viewModel?.userShared.userLogado?.displayName
        self.mailLabel.text = viewModel?.userShared.userLogado?.email
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(showCamera(tapGestureRecognizer:)))
        perfilImage.addGestureRecognizer(gesture)
        perfilImage.isUserInteractionEnabled = true
    }
    
    func setImage(_ image: UIImage) {
        self.perfilImage.image = image
    }
    
    func setDefaultImage() {
        self.perfilImage.image = UIImage(named: "DefaultPerfil")
    }
    
    @objc
    private func showCamera(tapGestureRecognizer: UITapGestureRecognizer) {
        self.delegate?.showCamera()
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
            make.width.equalTo(150)
            make.height.equalTo(150)
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
