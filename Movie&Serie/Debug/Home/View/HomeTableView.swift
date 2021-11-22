//
//  HomeTableViewController.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 28/06/21.
//

import Foundation
import UIKit
import AlamofireImage

enum CellType {
    case upcoming
    case allmovies
}

class HomeTableView: UITableView {
    
    private var viewModel: MovieViewModel?
    private var movieData: [[MovieViewData]] = []
    private var upcomingMovieData: [MovieViewData] = []
    private var cellTitle: [String] = []
    private var homeDelegate: MovieCollectionProtocol?
    private var movieType: [MovieType] = []
    private var cellType: CellType = .allmovies
    
    init() {
        super.init(frame: .zero, style: .plain)
        self.backgroundColor = .black

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildCell(cellType: CellType,
                   _ movieType: [MovieType],
                   viewModel: MovieViewModel,
                   delegate: MovieCollectionProtocol,
                   _ callback: @escaping () -> Void) {
        self.homeDelegate = delegate
        self.cellType = cellType
        self.viewModel = viewModel
        self.movieType = movieType
        registerCell()
        getMovie {
            callback()
        }
    }
    
    func registerCell() {
        switch cellType {
        case .upcoming:
            self.register(UpcomingViewCell.self, forCellReuseIdentifier: "MovieUpcomingCell")
        case .allmovies:
            self.register(HomeTableViewCell.self, forCellReuseIdentifier: "MovieCell")

        }
        self.delegate = self
        self.dataSource = self
    }
    
    func getMovie(_ callback: @escaping () -> Void) {
            movieData = []
        for type in movieType {
            viewModel?.getMovie(type: type) { movies in
                self.cellTitle.append(type.titleOfCell)
                switch self.cellType {
                case .upcoming:
                    self.upcomingMovieData = movies
                case .allmovies:
                    self.movieData.append(movies)
                }

                self.reloadData()
                callback()
            }
        }
    }
}

extension HomeTableView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch cellType {
        case .upcoming:
            return UITableView.automaticDimension
        case .allmovies:
            return CGFloat(300)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch cellType {
        case .upcoming:
            return upcomingMovieData.count
        case .allmovies:
            return movieData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch cellType {
        case .upcoming:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieUpcomingCell",
                                                           for: indexPath) as? UpcomingViewCell
            else { return UITableViewCell() }
            cell.isUserInteractionEnabled = false
            let data = upcomingMovieData[indexPath.row]
            if let backdropPath = data.backdropPath {
                let imageUrl = URL(string: "\(Constants.Url.imageOriginal)\(backdropPath)")
                if let url = imageUrl {
                    cell.movieBackground.af.setImage(withURL: url)
                }
            }
            
            cell.buildParameters(movie: data)
            return cell
        case .allmovies:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell",
                                                     for: indexPath) as? HomeTableViewCell
            else { return UITableViewCell() }
            let data = movieData[indexPath.row]
            cell.getProperties(sectionTitle: cellTitle[indexPath.row],
                               movie: data,
                               section: indexPath.section,
                               delegate: homeDelegate)
            return cell
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0 {
            self.homeDelegate?.hiddenTabBar(hidden: true, animated: true)
        } else {
            self.homeDelegate?.hiddenTabBar(hidden: false, animated: true)
        }
    }
}
