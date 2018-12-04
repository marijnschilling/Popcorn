//
// Created by Marijn Schilling on 04/12/2018.
// Copyright (c) 2018 Marijn Schilling. All rights reserved.
//

import Foundation

struct Video: Decodable {

//"id": "5aa8022b9251415e39020579",
//"iso_639_1": "en",
//"iso_3166_1": "US",
//"key": "5sEaYB4rLFQ",
//"name": "Fantastic Beasts: The Crimes of Grindelwald - Official Teaser Trailer",
//"site": "YouTube",
//"size": 1080,
//"type": "Teaser"
    let url: URL?

    private enum CodingKeys : String, CodingKey {
        case key
        case site
    }
}

extension Video {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let site = try container.decode(String.self, forKey: .key)
        let key = try container.decode(String.self, forKey: .key)

        guard site == "YouTube" else {
            url = nil
            return
        }

        url = URL.youTubeURL(for: key)
    }
}

struct VideoWrapper: Codable {
    
}