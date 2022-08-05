//
//  UIButton+Extension.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 22/09/21.
//

import Foundation
import UIKit

extension UIButton {
    func setButtonState(isEnabled: Bool,
                        enabledColor: UIColor = UIColor(rgb: 0x0044FF)) {
        if isEnabled {
            self.backgroundColor = enabledColor
            self.setTitleColor(.white, for: .normal)
            self.isEnabled = true
        } else {
            self.backgroundColor = UIColor(rgb: 0x979797)
            self.setTitleColor(.darkGray, for: .normal)
            self.isEnabled = false
        }
        
    }
}
