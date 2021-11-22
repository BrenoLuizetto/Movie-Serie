//
//  HomeErrorView.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 03/07/21.
//

import Foundation
import UIKit
import SnapKit

class ErrorView: UIView {
    
    private var callback: (() -> Void)?
        
    private lazy var errorTitle: UILabel = {
        let title = UILabel()
        title.numberOfLines = countLines(of: title, maxHeight: 40)
        title.lineBreakMode = .byWordWrapping
        title.font = UIFont(name: "Kailasa", size: 20)
        title.text = "Não foi possível conectar à Movie&Serie"
        title.textAlignment = .center
        title.textColor = .white
        return title
    }()
    
    private lazy var errorMessage: UILabel = {
        let title = UILabel()
        title.numberOfLines = countLines(of: title, maxHeight: 25)
        title.font = UIFont(name: "Helvetica", size: 15)
        title.text = "tente novamente"
        title.textAlignment = .center
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapReload(sender:)))
        title.addGestureRecognizer(tap)
        title.isUserInteractionEnabled = true
        title.textColor = .white
        
        return title
    }()
    
    private lazy var errorImage: UIImageView = {
        let errorImage = UIImageView()
        errorImage.contentMode = .scaleAspectFit
        errorImage.image = UIImage(named: "warning")
        return errorImage
    }()
    
    init(callback: @escaping () -> Void) {
        super.init(frame: CGRect())
        self.buildItens()
        self.buildViewHierarchy()
        self.makeConstraints()
        self.callback = callback
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func tapReload(sender: UITapGestureRecognizer) {
        DispatchQueue.main.async {
            UILabel.animate(withDuration: 5) {
                self.errorMessage.textColor = .red
            }
        }
        self.callback!()
    }
    
    private func countLines(of label: UILabel, maxHeight: CGFloat) -> Int {
        guard let labelText = label.text else {
            return 0
        }
        
        let rect = CGSize(width: label.bounds.width, height: maxHeight)
        let labelSize = labelText.boundingRect(with: rect,
                                               options: .usesLineFragmentOrigin,
                                               attributes: [NSAttributedString.Key.font: label.font!],
                                               context: nil)
        
        let lines = Int(ceil(CGFloat(labelSize.height) / label.font.lineHeight))
        return labelText.contains("\n") && lines == 1 ? lines + 1 : lines
   }
    
}

extension ErrorView: BuildViewConfiguration {
    func buildViewHierarchy() {
        self.addSubview(self.errorTitle)
        self.addSubview(self.errorMessage)
        self.addSubview(self.errorImage)
    }

    func configElements() {
        
    }

    func makeConstraints() {
        
        errorImage.snp.makeConstraints { make in
            make.centerY.equalTo(self.snp.centerY).offset(-65)
            make.left.equalTo(self.snp.left).offset(15)
            make.right.equalTo(self.snp.right).offset(-15)
            make.height.equalTo(100)
        }
        
        errorTitle.snp.makeConstraints { make in
            make.left.equalTo(self.snp.left).offset(15)
            make.top.equalTo(self.errorImage.snp.bottom).offset(20)
            make.right.equalTo(self.snp.right).offset(-15)
            make.height.equalTo(40)
        }
        
        errorMessage.snp.makeConstraints { make in
            make.left.equalTo(self.snp.left).offset(15)
            make.top.equalTo(self.errorTitle.snp.bottom).offset(5)
            make.right.equalTo(self.snp.right).offset(-15)
            make.height.equalTo(25)
        }
        
    }
    
    func buildItens() {}
    
}
