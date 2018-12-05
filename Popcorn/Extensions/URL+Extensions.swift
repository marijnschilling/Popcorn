//
// Created by Marijn Schilling on 04/12/2018.
// Copyright (c) 2018 Marijn Schilling. All rights reserved.
//

import Foundation

extension URL {
    static func youTubeURL(for key: String) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "www.youtube.com"
        components.path = "/watch"
        components.queryItems = [URLQueryItem(name: "v", value: key)]

        return components.url
    }
    
    static func fetchMovieURL(for apiKey: String, page: Int) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.themoviedb.org"
        components.path = "/3/movie/popular"
        components.queryItems = [URLQueryItem(name: "api_key", value: apiKey),
                                 URLQueryItem(name: "language", value: "en-US"),
                                 URLQueryItem(name: "page", value: "\(page)")]

        return components.url
    }
}