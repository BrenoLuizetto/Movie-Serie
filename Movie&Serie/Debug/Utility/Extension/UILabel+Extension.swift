//
//  UILabel+Extension.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 14/07/21.
//

import Foundation
import UIKit

extension UILabel {
    
    func releaseDateLabel() {
        self.lineBreakMode = .byWordWrapping
        self.numberOfLines = 1
        self.font = UIFont(name: "Avenir-Medium", size: 15)
        self.textColor = .white
        self.backgroundColor = UIColor(rgb: 0x3C7AFF)
        self.textAlignment = .center
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
    }
    
    func fitTextToBounds() {
            guard let text = text, let currentFont = font else { return }
        
        let bestFittingFont = UIFont.bestFittingFont(for: text, in: bounds, fontDescriptor: currentFont.fontDescriptor, additionalAttributes: basicStringAttributes)
            font = bestFittingFont
        }
        
    private var basicStringAttributes: [NSAttributedString.Key: Any] {
        var attribs = [NSAttributedString.Key: Any]()
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = self.textAlignment
            paragraphStyle.lineBreakMode = self.lineBreakMode
            attribs[.paragraphStyle] = paragraphStyle
            
            return attribs
        }
}
