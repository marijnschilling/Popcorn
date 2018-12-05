//
// Created by Marijn Schilling on 04/12/2018.
// Copyright (c) 2018 Marijn Schilling. All rights reserved.
//

import Foundation
import MoreCodable

final class MovieCatalogDataLoader {
    enum MovieCatalogDataLoaderError: Error {
        case badURL
        case unknown
        case noMoreMovies
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
            completion(nil, MovieCatalogDataLoaderError.badURL)
            return
        }

        dataLoader.fetchData(for: URLRequest(url: url), withSuccess: { [weak self] data in
            guard let dictionary = data as? NSDictionary,
                  let movieWrapper = try? DictionaryDecoder().decode(MovieWrapper.self, from: dictionary)  else { return }

            self?.movieCatalogPage = movieWrapper.page
            self?.totalPages = movieWrapper.totalPages

            completion(movieWrapper.results, nil)
         }, failure: { error in
            completion(nil, error ?? MovieCatalogDataLoaderError.unknown)
        })
    }

    func fetchMovieDetails(for identifier: Int, completion: @escaping (_ moviesDetails: MovieDetails?, _ error: Error?) -> Void) {

        guard let url = URL.fetchMovieDetailsURL(forIdentifier: identifier) else { return }

        dataLoader.fetchData(for: URLRequest(url: url), withSuccess: { data in
            guard let dictionary = data as? NSDictionary else {
                return
            }

            guard let movieDetails = try? DictionaryDecoder().decode(MovieDetails.self, from: dictionary)  else { return }

            completion(movieDetails, nil)
        }, failure: { error in
            completion(nil, error ?? MovieCatalogDataLoaderError.unknown)
        })
    }
}