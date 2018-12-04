//
// Created by Marijn Schilling on 04/12/2018.
// Copyright (c) 2018 Marijn Schilling. All rights reserved.
//

import XCTest
@testable import Popcorn

class ExtensionsTest: XCTestCase {

    func testYoutubeURL() {
        let youTubeURL = URL.youTubeURL(for: "key")
        XCTAssertEqual(youTubeURL?.absoluteString, "wikipedia://places?latitude=1.000000&longitude=2.000000")
    }
}
