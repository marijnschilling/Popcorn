//
// Created by Marijn Schilling on 04/12/2018.
// Copyright (c) 2018 Marijn Schilling. All rights reserved.
//

import Foundation

struct MovieDetails: Codable {
    let id: Int
    let title: String
    let tagline: String
    let overview: String
    let voteAverage: Double
    let releaseDate: Date
    let posterPath: String
    let backdropPath: String?

    private enum CodingKeys : String, CodingKey {
        case id
        case title
        case tagline
        case overview
        case voteAverage = "vote_average"
        case releaseDate = "release_date"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }
}

extension JSONDecoder {
    static let movieDetailsDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = DateDecodingStrategy.formatted(DateFormatter.yearMonthDay)

        return decoder
    }()
}