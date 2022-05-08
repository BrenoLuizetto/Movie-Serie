//
//  WarningView.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 22/09/21.
//

import Foundation
import UIKit
import SnapKit

class WarningView: UIView {
    
    private lazy var container: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(rgb: 0xFF1100)
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        return view
    }()
    
    private lazy var message: UILabel = {
        let lbl = UILabel()
        lbl.text = Constants.Labels.loginErrorMessage
        lbl.font = UIFont(name: Constants.Fonts.avenirHeavy, size: 18)
        lbl.textColor = .white
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private lazy var closeButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: Constants.Images.closeButton), for: .normal)
        btn.imageView?.tintColor = .white
        btn.imageView?.contentMode = .scaleAspectFit
        btn.addTarget(self, action: #selector(close), for: .touchUpInside)
        return btn
    }()
    
    var callback: (() -> Void)?
    
    init() {
        super.init(frame: .zero)
        buildItens()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func close() {
        callback?()
    }
}

extension WarningView: BuildViewConfiguration {
    func buildViewHierarchy() {
        self.addSubview(container)
        container.addSubview(message)
        container.addSubview(closeButton)
    }
    
    func makeConstraints() {
        container.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        message.snp.makeConstraints { make in
            make.left.top.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().offset(-15)
        }
        
        closeButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-15)
            make.top.equalToSuperview().offset(15)
            make.left.equalTo(message.snp.right).offset(10)
            make.height.equalTo(20)
//            make.bottom.equalToSuperview().offset(-15)
        }
    }
    
    func configElements() {
        
    }
    
}
