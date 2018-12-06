//
// Created by Marijn Schilling on 04/12/2018.
// Copyright (c) 2018 Marijn Schilling. All rights reserved.
//

import UIKit

extension URL {
    static func youTubeURL(for key: String) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "www.youtube.com"
        components.path = "/watch"
        components.queryItems = [URLQueryItem(name: "v", value: key)]

        return components.url
    }
    
    static func fetchMovieURL(forPage page: Int) -> URL? {
        var components = URLComponents.theMovieDBURLComponents()
        components.path.append("/popular")
        components.queryItems?.append(URLQueryItem(name: "page", value: "\(page)"))

        return components.url
    }

    static func fetchMovieDetailsURL(forIdentifier identifier: Int) -> URL? {
        var components = URLComponents.theMovieDBURLComponents()
        components.path.append("/\(identifier)")

        return components.url
    }

    static func fetchTrailerURL(forIdentifier identifier: Int) -> URL? {
        var components = URLComponents.theMovieDBURLComponents()
        components.path.append("/\(identifier)/videos")

        return components.url
    }

    static func downloadImageURL(forPath path: String, width: CGFloat) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "image.tmdb.org"
        components.path = "/t/p/w\(Int(width))\(path)"

        return components.url
    }
}

extension URLComponents {
    static func theMovieDBURLComponents() -> URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.themoviedb.org"
        components.path = "/3/movie"
        components.queryItems = [URLQueryItem(name: "api_key", value: MovieCatalogDataLoader.apiKey),
                                 URLQueryItem(name: "language", value: "en-US")]

        return components
    }
}