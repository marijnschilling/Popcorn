//
// Created by Marijn Schilling on 06/12/2018.
// Copyright (c) 2018 Marijn Schilling. All rights reserved.
//

import UIKit
import TinyConstraints

final class MovieDetailsViewController: UIViewController {
    private var movieDetails: MovieDetails
    private var dataLoader: MovieCatalogDataLoader

    private lazy var backgroundImageView = UIImageView()

    private lazy var overlayView: UIView = {
        let overlayView = UIView()
        overlayView.backgroundColor = .black
        overlayView.alpha = 0.8

        return overlayView
    }()

    private lazy var playerView = YouTubePlayerView()
    private lazy var activityIndicator = UIActivityIndicatorView()

    init(movieDetails: MovieDetails, dataLoader: MovieCatalogDataLoader) {
        self.movieDetails = movieDetails
        self.dataLoader = dataLoader
        super.init(nibName: nil, bundle: nil)

        title = movieDetails.title
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
            weakSelf.activityIndicator.startAnimating()
        }
    }

    private func showErrorAlert(_ error: Error?) {
        let alert = UIAlertController(title: "There was an error displaying the trailer", message: error?.localizedDescription ?? "No trailers where found", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))

        present(alert, animated: true)
    }

    private func addSubviewsAndConstraints() {
        view.addSubview(backgroundImageView)
        backgroundImageView.edges(to: view)

        view.addSubview(overlayView)
        overlayView.edges(to: view)

        view.addSubview(activityIndicator)
        activityIndicator.center(in: view)

        view.addSubview(playerView)
        playerView.edges(to: view)
    }
}
