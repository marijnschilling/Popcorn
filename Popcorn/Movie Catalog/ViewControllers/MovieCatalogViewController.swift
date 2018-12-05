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
    static let itemWidth = CGFloat(200.0)

    private var collectionView: UICollectionView
    private var dataLoader = MovieCatalogDataLoader()

    private var movies: [Movie]?

    init() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: MovieCatalogViewController.itemWidth, height: 300)
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
        dataLoader.fetchMovieCatalog { [weak self] movies, error in
            self?.movies = movies
            self?.collectionView.reloadData()
         }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCatalogCell.identifier, for: indexPath) as? MovieCatalogCell else {
            fatalError("Could not dequeue cell with identifier: \(MovieCatalogCell.identifier)")
        }

        guard let movie = movies?[indexPath.item] else { return cell }

        // TODO: fetch images asyncronously
        guard let url = URL.fetchPosterURL(forPosterPath: movie.posterPath), let data = try? Data(contentsOf: url) else {
            return cell
        }
        cell.imageView.image = UIImage(data: data)
        return cell
    }
}

