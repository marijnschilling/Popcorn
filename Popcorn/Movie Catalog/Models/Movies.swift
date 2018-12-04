//
// Created by Marijn Schilling on 04/12/2018.
// Copyright (c) 2018 Marijn Schilling. All rights reserved.
//

import Foundation

struct MovieWrapper: Codable {
    let page: Int
    let totalPages: Int
    let results: [Movie]

    private enum CodingKeys : String, CodingKey {
        case page
        case totalPages = "total_pages"
        case results
    }
}

struct Movie: Codable {
    let title: String
    let posterPath: String

    private enum CodingKeys : String, CodingKey {
        case title
        case posterPath = "poster_path"
    }
}
