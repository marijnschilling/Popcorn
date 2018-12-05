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
    let releaseDate: Date
    let posterPath: String
    let backdropPath: String

    private enum CodingKeys : String, CodingKey {
        case title
        case tagline
        case overview
        case voteAverage = "vote_average"
        case releaseDate = "release_date"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        tagline = try container.decode(String.self, forKey: .tagline)
        overview = try container.decode(String.self, forKey: .overview)
        voteAverage = try container.decode(Double.self, forKey: .voteAverage)
        posterPath = try container.decode(String.self, forKey: .posterPath)
        backdropPath = try container.decode(String.self, forKey: .backdropPath)

        let dateString = try container.decode(String.self, forKey: .releaseDate)
        let formatter = DateFormatter.yearMonthDay
        if let date = formatter.date(from: dateString) {
            releaseDate = date
        } else {
            throw DecodingError.dataCorruptedError(forKey: .releaseDate,
                    in: container,
                    debugDescription: "Date string does not match format expected by formatter.")
        }
    }
}