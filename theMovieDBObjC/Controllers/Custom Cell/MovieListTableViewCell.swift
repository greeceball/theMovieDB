//
//  MovieListTableViewCell.swift
//  theMovieDBObjC
//
//  Created by Colby Harris on 3/27/20.
//  Copyright © 2020 Colby_Harris. All rights reserved.
//

import UIKit

class MovieListTableViewCell: UITableViewCell {
    @IBOutlet weak var moviePosterImage: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieRatingLabel: UILabel!
    @IBOutlet weak var movieSummaryLabel: UILabel!
    
    var movie:CHMovie? {
        didSet {
            guard let movie = movie else { return }
            movieTitleLabel.text = movie.title
            movieRatingLabel.text = "Rating: \(String(movie.rating))"
            movieSummaryLabel.text = movie.shortDescription

// Working on getting poster to populate. it doesnt handle movies without posters
//            if postertemp == "" {
//                self.moviePosterImage.image = #imageLiteral(resourceName: "no poster")
//                return
//            } else {
//                CHMovieController.fetchPoster(movie) { (poster) in
//                    guard let poster = poster else { return }
//                    DispatchQueue.main.async {
//                        self.moviePosterImage.image = poster
//                    }
//                }
//            }
        }
    }
}
