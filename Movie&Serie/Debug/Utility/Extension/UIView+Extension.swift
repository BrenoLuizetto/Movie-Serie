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
    
    func startShimmer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.colors = [UIColor.white,
                                UIColor.lightGray,
                                UIColor.white]
        gradientLayer.locations = [0.0, 0.5, 1.0]
        
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [-1.0, -0.5, 0.0]
        animation.toValue = [1.0, 1.5, 2.0]
        animation.repeatCount = .infinity
        gradientLayer.add(animation, forKey: animation.keyPath)
        
        self.layer.addSublayer(gradientLayer)
        
    }
    
    func startShimmeringEffect() {
        let light = UIColor.white.cgColor
        let alpha = UIColor.lightGray.cgColor
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = [light, alpha, light]
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.locations = [0.0, 0.5, 1.0]
        self.layer.mask = gradient
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [-1.0, -0.5, 0.0]
        animation.toValue = [1.0, 1.5, 2.0]
        animation.duration = 1.5
        animation.repeatCount = HUGE
        gradient.add(animation, forKey: "shimmer")
    }
    
    func stopShimmeringEffect() {
        self.layer.mask = nil
    }
                        
}
