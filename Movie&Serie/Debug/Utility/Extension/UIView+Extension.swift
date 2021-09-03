//
//  UIViewController+Extension.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 02/09/21.
//

import UIKit
import MBProgressHUD

extension UIView {
    func showHUD() {
        MBProgressHUD.showAdded(to: self, animated: true)
    }
    
    func removeHUD() {
        MBProgressHUD.hide(for: self, animated: true)
    }
}
