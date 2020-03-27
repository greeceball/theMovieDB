//
//  MovieListTableViewController.swift
//  theMovieDBObjC
//
//  Created by Colby Harris on 3/27/20.
//  Copyright © 2020 Colby_Harris. All rights reserved.
//

import UIKit

class MovieListTableViewController: UITableViewController {
    
    @IBOutlet weak var movieSearchBar: UISearchBar!
    
    //MARK: - Properties
    var movieResults: [CHMovie] = []
    
    //MARK: - Lifcycle Funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        movieSearchBar.delegate = self
        tableView.rowHeight = 120
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return movieResults.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieListTableViewCell else {return UITableViewCell()}
        let movie = movieResults[indexPath.row]
        cell.movie = movie
        return cell
    }
}

extension MovieListTableViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = movieSearchBar.text, !searchText.isEmpty else { return }
        CHMovieController.fetchMovies(searchText) { (movie) in
            guard let movie = movie else { return }
            DispatchQueue.main.async {
                self.movieResults = movie
                self.tableView.reloadData()
            }
        }
    }
}

