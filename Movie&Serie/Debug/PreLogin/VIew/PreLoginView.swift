//
//  RegisterView.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 22/10/21.
//

import Foundation
import UIKit
import SnapKit

final class PreLoginView: UIView {
    
    var didTapStart: (() -> Void)?
    
    private lazy var container: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var backgroundImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "duna")
        img.contentMode = .scaleAspectFill
        img.isOpaque = true
        img.layer.opacity = 50
        return img
    }()
    
    lazy var gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.type = .axial
        gradient.colors = [
            UIColor.clear.cgColor,
            UIColor.black.cgColor
        ]
        gradient.locations = [0, 0.7]
        return gradient
    }()
    
    private lazy var filter: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = Constants.Labels.preLoginTitle
        lbl.font = UIFont(name: Constants.Fonts.avenirHeavy, size: 50)
        lbl.textColor = .white
        lbl.numberOfLines = 0
        lbl.contentMode = .center
        lbl.textAlignment = .center
        return lbl
    }()
    
    private lazy var messageLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = Constants.Labels.preLoginSubTitle
        lbl.font = UIFont(name: Constants.Fonts.avenirMedium, size: 20)
        lbl.textColor = .white
        lbl.numberOfLines = 0
        lbl.contentMode = .center
        lbl.textAlignment = .center
        return lbl
    }()
    
    private lazy var startButton: UIButton = {
        let btn = UIButton()
        btn.setTitle(Constants.Labels.begin, for: .normal)
        btn.setButtonState(isEnabled: true)
        btn.layer.cornerRadius = 5
        btn.layer.borderWidth = 1
        btn.addTarget(self,
                      action: #selector(start),
                      for: .touchUpInside)
        return btn
    }()
        
    init() {
        super.init(frame: .zero)
        buildItens()
        setGradientBackground()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setGradientBackground() {
        gradient.frame = UIScreen.main.bounds
        filter.layer.addSublayer(gradient)
    }
    
    @objc
    func start() {
        didTapStart?()
    }
}

extension PreLoginView: BuildViewConfiguration {
    func buildViewHierarchy() {
        self.addSubview(container)
        container.addSubview(backgroundImage)
        container.addSubview(filter)
        container.addSubview(titleLabel)
        container.addSubview(messageLabel)
        container.addSubview(startButton)
    }
    
    func makeConstraints() {
        container.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        filter.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(50)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)

        }
        
        messageLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)

        }
        
        startButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().offset(-32)
        }
        
    }
    
    func configElements() {
        
    }
        
}
