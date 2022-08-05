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
    private var cellType: CellType = .allmovies
        
    private var finishedLoadingInitialTableCells = false

    init() {
        super.init(frame: .zero, style: .plain)
        self.backgroundColor = .black

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildCell(cellType: CellType,
                   viewModel: MovieViewModel,
                   delegate: MovieCollectionProtocol,
                   _ callback: @escaping () -> Void) {
        self.homeDelegate = delegate
        self.cellType = cellType
        self.viewModel = viewModel
        registerCell()
    }
    
    func registerCell() {
        switch cellType {
        case .upcoming:
            self.register(UpcomingViewCell.self, forCellReuseIdentifier: Constants.CellIdentifier.movieUpcoming)
        case .allmovies:
            self.register(HomeTableViewCell.self, forCellReuseIdentifier: Constants.CellIdentifier.movieCell)
            self.register(TopMovieViewCell.self, forCellReuseIdentifier: Constants.CellIdentifier.topMovie)

        }
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.delegate = self
        self.dataSource = self
        self.isAccessibilityElement = false
        self.separatorStyle = .none
    }
    
    func refreshData(_ callback: @escaping () -> Void) {
        switch cellType {
        case .upcoming:
                self.setData {
                    callback()
                }
        case .allmovies:
            self.viewModel?.parametersForCell {
                self.setData {
                    callback()
                }
            }
        }
    }
    
    private func setData(_ callback: @escaping () -> Void) {
        self.cellTitle = []
        self.movieData = []
        guard let types = self.viewModel?.types else { return }
        for type in types {
            self.viewModel?.getMovie(type: type) { movies in
                if type.titleOfCell == Constants.CellTitle.topMovie,
                   self.cellTitle.first != Constants.CellTitle.topMovie {
                    self.cellTitle.insert(type.titleOfCell, at: 0)
                    self.movieData.insert(movies, at: 0)
                    
                } else {
                    self.cellTitle.append(type.titleOfCell)
                    switch self.cellType {
                    case .upcoming:
                        self.upcomingMovieData = movies
                    case .allmovies:
                        self.movieData.append(movies)
                    }
                }
                self.reloadWithTransition()
                callback()
            }
        }
    }
}

extension HomeTableView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
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
            return buildUpcomingCell(tableView,
                              indexPath)
        case .allmovies:
            if cellTitle[indexPath.row] == Constants.CellTitle.topMovie {
                return buildTopCell(tableView,
                             indexPath)
            }
            return buildGenericCell(tableView,
                                    indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        var lastInitialDisplayableCell = false

        if movieData.count > 0 && !finishedLoadingInitialTableCells {
            if let indexPathsForVisibleRows = tableView.indexPathsForVisibleRows,
                let lastIndexPath = indexPathsForVisibleRows.last, lastIndexPath.row == indexPath.row {
                lastInitialDisplayableCell = true
            }
        }

        if !finishedLoadingInitialTableCells {

            if lastInitialDisplayableCell {
                finishedLoadingInitialTableCells = true
            }

            cell.transform = CGAffineTransform(translationX: 0, y: self.rowHeight/2)
            cell.alpha = 0

            UIView.animate(withDuration: 0.5, delay: 0.05 * Double(indexPath.row),
                           options: [.curveEaseInOut],
                           animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0)
                cell.alpha = 1
            }, completion: nil)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0 {
            self.homeDelegate?.hiddenTabBar(hidden: true, animated: true)
        } else {
            self.homeDelegate?.hiddenTabBar(hidden: false, animated: true)
        }
    }
}

extension HomeTableView {
    
    func buildTopCell(_ tableView: UITableView,
                      _ indexPath: IndexPath ) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifier.topMovie,
                                                     for: indexPath) as? TopMovieViewCell,
                  let movie = movieData[indexPath.row].first,
                  let delegate = homeDelegate
            else { return UITableViewCell() }
            
            let backdropPath = movie.backdropPath
            let imageUrl = URL(string: "\(Constants.Url.imageOriginal)\(backdropPath ?? "")")
            if let url = imageUrl {
                UIView.animate(withDuration: 0.5,
                               animations: {cell.moviePoster.af.setImage(withURL: url)},
                               completion: nil)
            }
            cell.setup(viewModel: MovieDetailsViewModel(movie,
                                                        with: delegate))
            return cell
    }
    
    func buildUpcomingCell(_ tableView: UITableView,
                           _ indexPath: IndexPath ) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifier.movieUpcoming,
                                                       for: indexPath) as? UpcomingViewCell
        else { return UITableViewCell() }
        cell.isUserInteractionEnabled = false
        let data = upcomingMovieData[indexPath.row]
        if let backdropPath = data.backdropPath {
            let imageUrl = URL(string: "\(Constants.Url.imageOriginal)\(backdropPath)")
            if let url = imageUrl {
                UIView.animate(withDuration: 0.5,
                               animations: {cell.movieBackground.af.setImage(withURL: url)},
                               completion: nil)
            }
        }
        
        cell.buildParameters(movie: data)
        return cell
    }
    
    func buildGenericCell(_ tableView: UITableView,
                          _ indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifier.movieCell,
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
