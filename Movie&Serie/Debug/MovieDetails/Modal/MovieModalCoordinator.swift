//
//  MovieModalCoordinator.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 30/08/22.
//

import UIKit

class MovieModalCoordinator: Coordinator {
    
    let viewModel: MovieDetailsViewModel
    let navigationController: UINavigationController
    let movieCollectionAction: MovieCollectionAction?
    
    init(navigationController: UINavigationController,
        movieViewData: MovieViewData,
        movieCollectionAction: MovieCollectionAction?) {
        self.viewModel = MovieDetailsViewModel(movieViewData,
                                               routerProvider: RouterProvider(),
                                               delegate: movieCollectionAction)
        self.navigationController = navigationController
        self.movieCollectionAction = movieCollectionAction
    }
    
    func start() {
        setMovieDetails()
    }
    
    private func setMovieDetails() {
        let controller = MovieModalViewController(viewModel: viewModel)
//
//        let detailsTransitioningDelegate = InteractiveModalTransitioningDelegate(from: self.controller,
//                                                                                 to: vc)
        controller.modalPresentationStyle = .overCurrentContext
//        controller.transitioningDelegate = detailsTransitioningDelegate
        controller.definesPresentationContext = true
        
        navigationController.present(controller,
                                     animated: true,
                                     completion: nil)
    }
    
}
