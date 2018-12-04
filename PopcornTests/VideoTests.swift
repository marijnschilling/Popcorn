//
// Created by Marijn Schilling on 04/12/2018.
// Copyright (c) 2018 Marijn Schilling. All rights reserved.
//

import XCTest
@testable import Popcorn

class VideoTests: XCTestCase {

    func testVideoJSONMapping() {
        let bundle = Bundle(for: type(of: self))

        guard let url = bundle.url(forResource: "Videos", withExtension: "json") else {
            XCTFail("Missing file: Videos.json")
            return
        }

        guard let jsonData = try? Data(contentsOf: url) else {
            XCTFail("Corrupt file: Videos.json")
            return
        }

        do {
            let videoWrapper = try JSONDecoder().decode(VideoWrapper.self, from: jsonData)
            XCTAssertNotNil(videoWrapper)
            XCTAssertEqual(videoWrapper.url?.absoluteString, "https://www.youtube.com/watch?v=5sEaYB4rLFQ")
        } catch {
            XCTFail("Decoding error: \(error)")
        }
    }
}
