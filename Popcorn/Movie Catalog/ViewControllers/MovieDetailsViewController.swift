//
// Created by Marijn Schilling on 06/12/2018.
// Copyright (c) 2018 Marijn Schilling. All rights reserved.
//

import UIKit
import TinyConstraints

final class MovieDetailsViewController: UIViewController {
    private var movieDetails: MovieDetails
    private var dataLoader: MovieCatalogDataLoader

    private lazy var backgroundImageView: UIImageView = {
        let backgroundImage = UIImageView()
        backgroundImage.alpha = 0.3

        return backgroundImage
    }()

    private lazy var playerView: YouTubePlayerView = {
        let playerView = YouTubePlayerView()

        return playerView
    }()

    init(movieDetails: MovieDetails, dataLoader: MovieCatalogDataLoader) {
        self.movieDetails = movieDetails
        self.dataLoader = dataLoader
        super.init(nibName: nil, bundle: nil)

        title = movieDetails.title
        view.backgroundColor = .darkGray
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        addSubviewsAndConstraints()

        if let backdropPath = movieDetails.backdropPath {
            dataLoader.downloadImage(for: backdropPath, width: 300) { [weak self] image, error in
                self?.backgroundImageView.image = image
            }
        }

        dataLoader.fetchTrailerURL(for: movieDetails.id) { [weak self] url, error in
            guard let weakSelf = self else { return }
            guard let url = url else {
                weakSelf.showErrorAlert(error)
                return
            }
            weakSelf.playerView.loadVideoURL(url)
         }
    }

    private func showErrorAlert(_ error: Error?) {

    }

    private func addSubviewsAndConstraints() {
        view.addSubview(backgroundImageView)
        backgroundImageView.edges(to: view)
        view.addSubview(playerView)
        playerView.edges(to: view)
    }
}
