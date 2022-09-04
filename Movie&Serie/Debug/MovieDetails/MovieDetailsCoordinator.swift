//
//  MovieDetailsCoordinator.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 30/08/22.
//

import Foundation
import UIKit

protocol Coordinator {
    func start()
}

class MovieDetailsCoordinator: Coordinator {
        
    let viewModel: MovieDetailsViewModel
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController,
        movieViewData: MovieViewData,
         movieCollectionAction: MovieCollectionAction?) {
        self.viewModel = MovieDetailsViewModel(movieViewData,
                                               routerProvider: RouterProvider(),
                                               delegate: movieCollectionAction)
        self.navigationController = navigationController
    }
    
    func start() {
        setMovieDetails()
    }
    
    private func setMovieDetails() {
        let controller = MovieDetailsViewController(viewModel: viewModel)
        navigationController.pushViewController(controller,
                                                animated: true)
    }
}
