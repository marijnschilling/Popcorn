//
// Created by Marijn Schilling on 04/12/2018.
// Copyright (c) 2018 Marijn Schilling. All rights reserved.
//

import XCTest
@testable import Popcorn

class ExtensionsTest: XCTestCase {

    func testYoutubeURL() {
        let youTubeURL = URL.youTubeURL(for: "key")
        XCTAssertEqual(youTubeURL?.absoluteString, "https://www.youtube.com/watch?v=key")
    }

    func testMovieURL() {
        let youTubeURL = URL.fetchMovieURL(forPage: 4)
        XCTAssertEqual(youTubeURL?.absoluteString, "https://api.themoviedb.org/3/movie/popular?api_key=3b7ad5dde84acc0a427e3fd01285a3c1&language=en-US&page=4")
    }

    func testMovieDetailsURL() {
        let youTubeURL = URL.fetchMovieDetailsURL(forIdentifier: 12344)
        XCTAssertEqual(youTubeURL?.absoluteString, "https://api.themoviedb.org/3/movie/12344?api_key=3b7ad5dde84acc0a427e3fd01285a3c1&language=en-US")
    }
}
