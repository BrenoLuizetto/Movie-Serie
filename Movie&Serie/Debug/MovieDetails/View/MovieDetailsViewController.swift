//
//  MovieDetailsViewController.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 10/07/21.
//

import Foundation
import UIKit
import MBProgressHUD

class MovieDetailsViewController: UIViewController {
    
    private var viewModel: MovieDetailsViewModel
    private var movieDetailsView: MovieDetailsView?
    
    init(viewModel: MovieDetailsViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
        self.view.showHUD()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height + 1000)
    }
    
    override func viewDidLoad() {
        movieDetailsView = MovieDetailsView(self.viewModel, delegate: MovieCollectionAction(controller: self))
        self.configNavBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.view = movieDetailsView
        movieDetailsView?.setScrollView()
        self.view.removeHUD()
    }

}

extension MovieDetailsViewController {
    private func configNavBar() {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Voltar", style: .plain, target: self, action: #selector(backAction(sender:)))
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addFavorite(sender:)))
    }
    
    @objc
    func addFavorite(sender: UIBarButtonItem) {
//        MovieUserDefaults.set(movie: self.viewModel.movie)
        let us = UserDefaults.standard
        do {
//            us.setObject(viewModel.movie, forKey: "favoriteMovies")
            try us.setObject(viewModel.movie.originalTitle, forKey: "favoriteMovies")
            print(try us.getObject(forKey: "favoriteMovies", castTo: String.self))
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @objc
    func backAction(sender: UIBarButtonItem) {
    navigationController?.popViewController(animated: true)
    }
}
