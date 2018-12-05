//
//  MovieCatalogViewController.swift
//  Popcorn
//
//  Created by Marijn Schilling on 04/12/2018.
//  Copyright © 2018 Marijn Schilling. All rights reserved.
//

import UIKit
import TinyConstraints

class MovieCatalogViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate  {
    static let itemWidth = 200

    private var collectionView: UICollectionView
    private var dataLoader = MovieCatalogDataLoader()

    private var movies = [Movie]()

    private var isLoadingMovieCatalog = false

    init() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: CGFloat(MovieCatalogViewController.itemWidth), height: 300)
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(MovieCatalogCell.self, forCellWithReuseIdentifier: MovieCatalogCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.darkGray

        addSubviewsAndConstraints()

        loadMovieCatalog()
    }

    private func addSubviewsAndConstraints() {
        view.addSubview(collectionView)

        collectionView.edges(to: view)
    }

    private func loadMovieCatalog() {
        isLoadingMovieCatalog = true
        dataLoader.fetchMovieCatalog { [weak self] movies, error in

            if let movies = movies {
                self?.movies.append(contentsOf: movies)
            }
            self?.collectionView.reloadData()
            self?.isLoadingMovieCatalog = false
         }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCatalogCell.identifier, for: indexPath) as? MovieCatalogCell else {
            fatalError("Could not dequeue cell with identifier: \(MovieCatalogCell.identifier)")
        }

        let movie = movies[indexPath.item]

        // TODO: fetch images asynchronously
        guard let url = URL.fetchPosterURL(forPosterPath: movie.posterPath), let data = try? Data(contentsOf: url) else {
            return cell
        }
        cell.imageView.image = UIImage(data: data)

        if (indexPath.item == movies.count - 1 ) {
            loadMovieCatalog()
        }

        return cell
    }
}

