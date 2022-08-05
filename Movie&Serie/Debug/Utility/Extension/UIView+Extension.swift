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
        let hud = MBProgressHUD.showAdded(to: self, animated: true)
        hud.mode = MBProgressHUDMode.indeterminate
        hud.label.text = "carregando"
        
    }
    
    func removeHUD() {
        MBProgressHUD.hide(for: self, animated: true)
    }
    
    func removeAllViews() {
        for view in subviews {
            view.removeFromSuperview()
        }
    }
    
    func setBlurView() {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        UIView.transition(with: self,
                          duration: 0.5,
                          options: .transitionCrossDissolve,
                          animations: {
            self.addSubview(blurEffectView)
            blurEffectView.snp.makeConstraints { make in
                make.left.top.right.bottom.equalToSuperview()
            }
        }, completion: nil)

    }
    
    func removeBlurView() {
        for subview in self.subviews {
            if subview.isKind(of: UIVisualEffectView.self) {
                UIView.transition(with: self,
                                  duration: 0.5,
                                  options: .transitionCrossDissolve,
                                  animations: {
                    subview.removeFromSuperview()
                }, completion: nil)
            }
        }
    }
}
