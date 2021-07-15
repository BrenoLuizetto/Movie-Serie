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
    
    init(viewModel: MovieDetailsViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        configNavBar()
        self.view = MovieDetailsView(self.viewModel, originHeight: self.view.bounds.width)

    }
    
    override func viewDidLoad() {
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    private func configNavBar() {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.title = "Descrição"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Voltar", style: .plain, target: self, action: #selector(backAction(sender:)))
        
    }
    
    @objc func backAction(sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }

}
