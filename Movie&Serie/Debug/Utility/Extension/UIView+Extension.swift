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
        
        func addGradientLayer() -> CAGradientLayer {
            
            let gradientLayer = CAGradientLayer()
            
            var gradientColorOne : CGColor = UIColor.lightGray.cgColor
            var gradientColorTwo : CGColor = UIColor.darkGray.cgColor
            
            gradientLayer.frame = self.bounds
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
            gradientLayer.colors = [gradientColorOne, gradientColorTwo, gradientColorOne]
            gradientLayer.locations = [0.0, 0.5, 1.0]
            self.layer.addSublayer(gradientLayer)
            
            return gradientLayer
        }
        
        func addAnimation() -> CABasicAnimation {
           
            let animation = CABasicAnimation(keyPath: "locations")
            animation.fromValue = [-1.0, -0.5, 0.0]
            animation.toValue = [1.0, 1.5, 2.0]
            animation.repeatCount = .infinity
            animation.duration = 0.9
            return animation
        }
        
        func startAnimatingShimmer() {
            
            let gradientLayer = addGradientLayer()
            let animation = addAnimation()
           
            gradientLayer.add(animation, forKey: animation.keyPath)
        }
    
    func removeShimmer() {
        if self.layer.sublayers != nil {
            self.layer.sublayers?.removeAll()
            self.layer.removeAllAnimations()
        }
    }
}
