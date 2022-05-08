//
//  RadioButton.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 11/03/22.
//

import UIKit
import SnapKit

final class RadioButton: UIButton {
    
    private let radioSize: CGFloat
    
    init(frame: CGRect = .zero,
         radioSize: CGFloat = 26) {
        self.radioSize = radioSize
        super.init(frame: frame)
        setView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setView() {
        self.layer.cornerRadius = 30
        self.layer.masksToBounds = true
    }
}
