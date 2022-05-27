//
//  UICollectionView+Extension.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 11/05/22.
//

import Foundation
import UIKit

extension UICollectionView {
    
    func reloadWithTransition() {
        UIView.transition(with: self,
                          duration: 1.0,
                          options: .transitionCrossDissolve,
                          animations: {self.reloadData()},
                          completion: nil)
    }
}
