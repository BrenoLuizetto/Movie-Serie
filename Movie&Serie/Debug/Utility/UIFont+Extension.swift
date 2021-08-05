//
//  UIFont+Extension.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 19/07/21.
//

import Foundation
import UIKit

extension UIFont {
    static func bestFittingFontSize(for text: String, in bounds: CGRect, fontDescriptor: UIFontDescriptor, additionalAttributes: [NSAttributedString.Key: Any]? = nil) -> CGFloat {
            let constrainingDimension = min(bounds.width, bounds.height)
            let properBounds = CGRect(origin: .zero, size: bounds.size)
            var attributes = additionalAttributes ?? [:]
            
            let infiniteBounds = CGSize(width: CGFloat.infinity, height: CGFloat.infinity)
            var bestFontSize: CGFloat = constrainingDimension
            
            for fontSize in stride(from: bestFontSize, through: 0, by: -1) {
                let newFont = UIFont(descriptor: fontDescriptor, size: fontSize)
                attributes[.font] = newFont
                
                let currentFrame = text.boundingRect(with: infiniteBounds, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: attributes, context: nil)
                
                if properBounds.contains(currentFrame) {
                    bestFontSize = fontSize
                    break
                }
            }
            return bestFontSize
        }
        
    static func bestFittingFont(for text: String, in bounds: CGRect, fontDescriptor: UIFontDescriptor, additionalAttributes: [NSAttributedString.Key: Any]? = nil) -> UIFont {
            let bestSize = bestFittingFontSize(for: text, in: bounds, fontDescriptor: fontDescriptor, additionalAttributes: additionalAttributes)
            return UIFont(descriptor: fontDescriptor, size: bestSize)
    }
}
