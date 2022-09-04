//
//  MovieCollectionViewProtocol.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 27/07/21.
//

import Foundation
import UIKit
import SnapKit
import MBProgressHUD

protocol MovieCollectionProtocol: AnyObject {
    func didSelectItem(movie: MovieViewData)
    func finishLoad()
    func hiddenTabBar(hidden: Bool, animated: Bool)
    func showDetailsScreen(movie: MovieViewData)
    func showErrorMessage(_ title: String,
                          _ message: String)
    func didScroll()
    func setBlur(hasBlur: Bool)
}

class MovieCollectionAction: NSObject, MovieCollectionProtocol {
    
    let controller: UIViewController
    
    init(controller: UIViewController) {
        self.controller = controller
    }
    
    func finishLoad() {
        self.controller.view.removeHUD()
    }
    
    func didSelectItem(movie: MovieViewData) {
        let coordinator = MovieModalCoordinator(navigationController: controller.navigationController ?? UINavigationController(),
                                                movieViewData: movie,
                                                movieCollectionAction: self)        
        setBlur(hasBlur: true)
        self.hiddenTabBar(hidden: true, animated: true)
        coordinator.start()
    }
    
    func hiddenTabBar(hidden: Bool, animated: Bool) {
        let tabBar = self.controller.tabBarController?.tabBar
        let offset = (hidden ? UIScreen.main.bounds.size.height :
                        UIScreen.main.bounds.size.height - (tabBar?.frame.size.height)! )
        if offset == tabBar?.frame.origin.y {return}
        let duration: TimeInterval = (animated ? 0.5 : 0.0)
        UIView.animate(withDuration: duration,
                       animations: {tabBar!.frame.origin.y = offset},
                       completion: nil)
    }
    
    func showDetailsScreen(movie: MovieViewData) {
        guard let navigationController = controller.navigationController else { return }
        let coordinator = MovieDetailsCoordinator(navigationController: navigationController,
                                                  movieViewData: movie,
                                                  movieCollectionAction: self)
        coordinator.start()
    }
    
    func showErrorMessage(_ title: String, _ message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .destructive, handler: nil))
        controller.navigationController?.present(alert, animated: true, completion: nil)
    }
    
    func didScroll() {
        self.controller.view.endEditing(true)
    }
    
    func setBlur(hasBlur: Bool) {
        if hasBlur {
            controller.view.setBlurView()
        } else {
            controller.view.removeBlurView()
        }
    }
}
