//
// Created by Marijn Schilling on 04/12/2018.
// Copyright (c) 2018 Marijn Schilling. All rights reserved.
//

import Foundation
import MoreCodable

final class MovieCatalogDataLoader {
    enum MovieCatalogDataLoaderError: Error {
        case unknown
    }

    private static let apiKey = "3b7ad5dde84acc0a427e3fd01285a3c1"

    private let dataLoader = DataLoader()

    private var movieCatalogPage = 0
    private var totalPages = 1

    func fetchMovieCatalog(completion: @escaping (_ movies: [Movie]?, _ error: Error?) -> Void) {

        guard movieCatalogPage < totalPages else { return } // There's no more movies to fetch
        guard let url = URL.fetchMovieURL(for: MovieCatalogDataLoader.apiKey, page: movieCatalogPage + 1) else { return }

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
}