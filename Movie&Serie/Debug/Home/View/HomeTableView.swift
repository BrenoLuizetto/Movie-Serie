//
//  HomeTableViewController.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 28/06/21.
//

import Foundation
import UIKit
import AlamofireImage

class HomeTableView: UITableView, UITableViewDataSource, UITableViewDelegate {
    
    private var viewModel: HomeViewModel?
    private var movieData: Array<Array<MovieViewData>> = []
    private var cellTitle: [String] = []
    private var homeDelegate: HomeProtocol?
    
    func buildCell(_ movieType: [MovieType], viewModel: HomeViewModel,delegate: HomeProtocol,_ callback: @escaping () -> Void) {
        self.homeDelegate = delegate
        self.backgroundColor = .black
        self.viewModel = viewModel
        registerCell()
        getMovie(movieType: movieType) {
            callback()
        }
    }
    
    func registerCell() {
        self.register(HomeTableViewCell.self, forCellReuseIdentifier: "MovieCell")
        self.delegate = self
        self.dataSource = self
    }
    
    func getMovie(movieType: [MovieType],_ callback: @escaping () -> Void) {
            movieData = []
        for type in movieType {
            viewModel?.getMovie(type: type) { movies in
                self.cellTitle.append(type.titleOfCell)
                self.movieData.append(movies)
                self.reloadData()
                callback()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(300)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! HomeTableViewCell
        let data = movieData[indexPath.row]
        cell.getProperties(sectionTitle: cellTitle[indexPath.row], movie: data, section: indexPath.section, delegate: homeDelegate)
        
        return cell
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0 {
            self.homeDelegate?.hiddenTabBar(hidden: true, animated: true)
        } else {
            self.homeDelegate?.hiddenTabBar(hidden: false, animated: true)
        }
    }
}
