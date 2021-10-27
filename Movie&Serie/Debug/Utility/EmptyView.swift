//
//  EmptyView.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 21/10/21.
//

import Foundation
import UIKit

class EmptyView: UIView {
    
    private lazy var container: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var title: UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.font = UIFont(name: MovieConstants.Fonts.avenirHeavy, size: 18)
        lbl.textColor = .white
        lbl.text = "Opss"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        return lbl
    }()
    
    private lazy var message: UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.font = UIFont(name: MovieConstants.Fonts.avenirHeavy, size: 14)
        lbl.textColor = .white
        lbl.text = "Não encotramos nenhum resultado para sua pesquisa"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.lineBreakMode = .byTruncatingTail
        return lbl
    }()
    
    init() {
        super.init(frame: .zero)
        self.buildItens()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildItens() {
        self.addSubview(container)
        self.addSubview(title)
        self.addSubview(message)
        
        self.container.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor).isActive = true
        self.container.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor).isActive = true
        self.container.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        self.container.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor).isActive = true

        self.title.leftAnchor.constraint(equalTo: container.leftAnchor, constant: 16).isActive = true
        self.title.rightAnchor.constraint(equalTo: container.rightAnchor, constant: -16).isActive = true
        self.title.topAnchor.constraint(equalTo: container.topAnchor, constant: 16).isActive = true

        self.message.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 5).isActive = true
        self.message.leftAnchor.constraint(equalTo: container.leftAnchor, constant: 16).isActive = true
        self.message.rightAnchor.constraint(equalTo: container.rightAnchor, constant: -16).isActive = true
    }
}
