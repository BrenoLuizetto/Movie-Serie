//
//  MovieDetailsViewController.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 10/07/21.
//

import Foundation
import UIKit

class MovieDetailsViewController: UIViewController {
    
    private var viewModel: MovieDetailsViewModel
    private var movieDetailsView: MovieDetailsView?
    
    init(viewModel: MovieDetailsViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height + 1000)
    }
    
    override func viewDidLoad() {
        self.configNavBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        movieDetailsView = MovieDetailsView(self.viewModel, originWidth: self.view.bounds.width, originHeight: self.view.bounds.height)
        self.view = movieDetailsView
        movieDetailsView?.scrollView.contentSize = (CGSize(width: self.view.bounds.width, height: 2000))        
    }

}

extension MovieDetailsViewController {
    private func configNavBar() {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Voltar", style: .plain, target: self, action: #selector(backAction(sender:)))
    }
    
    @objc func backAction(sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
}
