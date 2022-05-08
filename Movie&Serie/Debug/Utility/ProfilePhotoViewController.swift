//
//  ProfilePhotoViewController.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 11/03/22.
//

import UIKit

final class ProfilePhotoViewController: BaseViewController {
    
    private lazy var profileImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        return imgView
    }()
    
    var profilePicture: UIImage
    
    init(profilePicture: UIImage) {
        self.profilePicture = profilePicture
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.profileImageView.image = profilePicture
        self.configNavBar()
        self.buildItens()
    }
    
    private func configNavBar() {
        self.navigationController?.isNavigationBarHidden = false
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: Constants.Labels.back,
                                                                style: .plain,
                                                                target: self, action: #selector(backAction(sender:)))
        
    }
    
    @objc func backAction(sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
}

extension ProfilePhotoViewController: BuildViewConfiguration {
    func buildViewHierarchy() {
        self.view.addSubview(profileImageView)
    }
    
    func makeConstraints() {
        profileImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(90)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-90)
        }
    }
    
    func configElements() {
        //not implemented
    }
    
}
