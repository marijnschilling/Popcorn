//
// Created by Marijn Schilling on 04/12/2018.
// Copyright (c) 2018 Marijn Schilling. All rights reserved.
//

import Foundation

struct MovieDetails: Codable {
    let title: String
    let tagline: String
    let overview: String
    let voteAverage: Double
    let posterPath: String
    let backdropPath: String

    private enum CodingKeys : String, CodingKey {
        case title
        case tagline
        case overview
        case voteAverage = "vote_average"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }
}