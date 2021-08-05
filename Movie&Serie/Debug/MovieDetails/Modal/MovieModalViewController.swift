//
//  MovieDetailsViewController.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 03/07/21.
//

import Foundation
import UIKit
import SnapKit

class MovieModalViewController: UIViewController {
    
    private var DetailsView: DetailsModalView = {
        let view = DetailsModalView()
        view.backgroundColor = UIColor(rgb: 0x282828)


        return view
    }()
    
    private var viewModel: MovieDetailsViewModel
    
    init(viewModel: MovieDetailsViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.DetailsView.buildInfo(viewModel, controller: self)
        
        buildItems()
        let Viewtap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        self.view.addGestureRecognizer(Viewtap)
        
        let Detailstap = UITapGestureRecognizer(target: self, action: #selector(self.didTapOnDetailsView(_:)))
        self.DetailsView.addGestureRecognizer(Detailstap)
        
    }

}

extension MovieModalViewController {
    
    @objc func didTapOnDetailsView(_ sender: UITapGestureRecognizer? = nil) {
        self.viewModel.delegate?.hiddenTabBar(hidden: false, animated: true)
        self.dismiss(animated: true, completion: nil)
        self.viewModel.delegate?.showDetailsScreen(movie: self.viewModel.movie)
    }

    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        self.viewModel.delegate?.hiddenTabBar(hidden: false, animated: true)
        self.dismiss(animated: true, completion: nil)
    }
}

extension MovieModalViewController: BuildViewConfiguration {
    func makeConstraints() {
        DetailsView.snp.makeConstraints { make in
            make.left.equalTo(self.view.snp.left)
            make.right.equalTo(self.view.snp.right)
            make.bottom.equalTo(self.view.snp.bottom)
            make.height.equalTo(280)
        }
    }
    
    func buildViewHierarchy() {
        self.view.addSubview(DetailsView)
    }
    
    func configElements() {
        //Not Implemented
    }
}
