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
        let viewModel = MovieDetailsViewModel(movie, with: self)
        let vc = MovieModalViewController(viewModel: viewModel)
        let detailsTransitioningDelegate = InteractiveModalTransitioningDelegate(from: self.controller, to: vc)
        vc.modalPresentationStyle = .overCurrentContext
        vc.transitioningDelegate = detailsTransitioningDelegate
        vc.definesPresentationContext = true
        self.hiddenTabBar(hidden: true, animated: true)
        self.controller.present(vc, animated: true, completion: nil)
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
        let viewModel = MovieDetailsViewModel(movie, with: self)
        let vc = MovieDetailsViewController(viewModel: viewModel)
        self.controller.navigationController?.pushViewController(vc, animated: true)
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
}
