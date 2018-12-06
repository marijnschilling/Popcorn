//
// Created by Marijn Schilling on 04/12/2018.
// Copyright (c) 2018 Marijn Schilling. All rights reserved.
//

import UIKit

final class MovieCatalogDataLoader {
    enum MovieCatalogDataLoaderError: Error {
        case invalidURL
        case invalidResponse
        case noMoreMovies
        case unknown
    }

    static let apiKey = "3b7ad5dde84acc0a427e3fd01285a3c1"

    private let dataLoader = DataLoader()

    private var movieCatalogPage = 0
    private var totalPages = 1

    func fetchMovieCatalog(completion: @escaping (_ movies: [Movie]?, _ error: Error?) -> Void) {

        guard movieCatalogPage < totalPages else {
            completion(nil, MovieCatalogDataLoaderError.noMoreMovies)
            return
        }

        guard let url = URL.fetchMovieURL(forPage: movieCatalogPage + 1) else {
            completion(nil, MovieCatalogDataLoaderError.invalidURL)
            return
        }

        dataLoader.fetchData(for: URLRequest(url: url), withSuccess: { [weak self] data in
            guard let data = data as? Data, let movieWrapper = try? JSONDecoder().decode(MovieWrapper.self, from: data)  else {
                completion(nil, MovieCatalogDataLoaderError.invalidResponse)
                return
            }

            self?.movieCatalogPage = movieWrapper.page
            self?.totalPages = movieWrapper.totalPages

            completion(movieWrapper.results, nil)
         }, failure: { error in
            completion(nil, error ?? MovieCatalogDataLoaderError.unknown)
        })
    }

    func fetchMovieDetails(for identifier: Int, completion: @escaping (_ moviesDetails: MovieDetails?, _ error: Error?) -> Void) {

        guard let url = URL.fetchMovieDetailsURL(forIdentifier: identifier) else {
            completion(nil, MovieCatalogDataLoaderError.invalidURL)
            return
        }

        dataLoader.fetchData(for: URLRequest(url: url), withSuccess: { data in
            guard let data = data as? Data, let movieDetails = try? JSONDecoder.movieDetailsDecoder.decode(MovieDetails.self, from: data)  else {
                completion(nil, MovieCatalogDataLoaderError.invalidResponse)
                return
            }

            completion(movieDetails, nil)
        }, failure: { error in
            completion(nil, error ?? MovieCatalogDataLoaderError.unknown)
        })
    }


    func fetchTrailerURL(for identifier: Int, completion: @escaping (_ trailerURL: URL?, _ error: Error?) -> Void) {

        guard let url = URL.fetchTrailerURL(forIdentifier: identifier) else {
            completion(nil, MovieCatalogDataLoaderError.invalidURL)
            return
        }

        dataLoader.fetchData(for: URLRequest(url: url), withSuccess: { data in
            guard let data = data as? Data, let videoWrapper = try? JSONDecoder().decode(VideoWrapper.self, from: data)  else {
                completion(nil, MovieCatalogDataLoaderError.invalidResponse)
                return
            }

            completion(videoWrapper.url, nil)
        }, failure: { error in
            completion(nil, error ?? MovieCatalogDataLoaderError.unknown)
        })
    }

    func downloadPosterImage(for posterPath: String, completion: @escaping (_ poster: UIImage?, _ error: Error?) -> Void) {

        guard let url = URL.downloadPosterURL(forPosterPath: posterPath) else {
            completion(nil, MovieCatalogDataLoaderError.invalidURL)
            return
        }

        dataLoader.fetchData(for: URLRequest(url: url), withSuccess: { data in
            guard let data = data as? Data else {
                completion(nil, MovieCatalogDataLoaderError.invalidResponse)
                return
            }

            guard let image = UIImage(data: data) else {
                completion(nil, MovieCatalogDataLoaderError.invalidResponse)
                return
            }

            completion(image, nil)
        }, failure: { error in
            completion(nil, error ?? MovieCatalogDataLoaderError.unknown)
        })
    }
}