//
// Created by Marijn Schilling on 04/12/2018.
// Copyright (c) 2018 Marijn Schilling. All rights reserved.
//

import Foundation


struct VideoWrapper: Decodable {
    var url: URL? {
        // TODO: Look at these mapping operations, maybe they can be improved
        return results.map { $0.url }.compactMap { $0 }.first
    }

    let results: [Video]
}

struct Video: Decodable {
    let url: URL?

    private enum CodingKeys : String, CodingKey {
        case key
        case site
    }
}

extension Video {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let site = try container.decode(String.self, forKey: .site)
        let key = try container.decode(String.self, forKey: .key)

        guard site == "YouTube" else {
            url = nil
            return
        }

        url = URL.youTubeURL(for: key)
    }
}
