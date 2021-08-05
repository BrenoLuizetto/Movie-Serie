//
//  MovieCollectionViewProtocol.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 27/07/21.
//

import Foundation
import UIKit

protocol MovieCollectionProtocol: AnyObject {
    func didSelectItem(movie: MovieViewData)
    func finishLoad()
    func hiddenTabBar(hidden: Bool, animated: Bool)
    func showDetailsScreen(movie: MovieViewData)
}

class MovieCollectionAction: NSObject, MovieCollectionProtocol {
    let controller: UIViewController
    
    init(controller: UIViewController) {
        self.controller = controller
    }
    
    func finishLoad() {
        self.controller.view.removeLoader()
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
        self.controller.view.removeLoader()
    }
    
    func hiddenTabBar(hidden: Bool, animated: Bool) {
        let tabBar = self.controller.tabBarController?.tabBar
        let offset = (hidden ? UIScreen.main.bounds.size.height : UIScreen.main.bounds.size.height - (tabBar?.frame.size.height)! )
        if offset == tabBar?.frame.origin.y {return}
        let duration:TimeInterval = (animated ? 0.5 : 0.0)
        UIView.animate(withDuration: duration,
                       animations: {tabBar!.frame.origin.y = offset},
                       completion:nil)
    }
    
    
    func showDetailsScreen(movie: MovieViewData) {
        let viewModel = MovieDetailsViewModel(movie, with: self)
        let vc = MovieDetailsViewController(viewModel: viewModel)
        self.controller.navigationController?.pushViewController(vc, animated: true)
    }
}
