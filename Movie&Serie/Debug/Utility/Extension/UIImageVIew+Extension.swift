//
//  UIImageVIew+Extension.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 20/12/21.
//

import Foundation
import UIKit

extension UIImageView {

   func setRounded() {
      let radius = self.frame.width/2
      self.layer.cornerRadius = radius
      self.layer.masksToBounds = true
   }
}
