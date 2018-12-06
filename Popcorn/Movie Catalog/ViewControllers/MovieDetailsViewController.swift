//
// Created by Marijn Schilling on 06/12/2018.
// Copyright (c) 2018 Marijn Schilling. All rights reserved.
//

import UIKit

final class MovieDetailsViewController: UIViewController {
    private var movieDetails: MovieDetails

    init(movieDetails: MovieDetails) {
        self.movieDetails = movieDetails
        super.init(nibName: nil, bundle: nil)

        title = movieDetails.title
        view.backgroundColor = .darkGray
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
