//
// Created by Marijn Schilling on 04/12/2018.
// Copyright (c) 2018 Marijn Schilling. All rights reserved.
//

import XCTest
@testable import Popcorn

class MovieTests: XCTestCase {

    func testMoviesJSONMapping() {
        let bundle = Bundle(for: type(of: self))

        guard let url = bundle.url(forResource: "Movies", withExtension: "json") else {
            XCTFail("Missing file: Movies.json")
            return
        }

        guard let jsonData = try? Data(contentsOf: url) else {
            XCTFail("Corrupt file: Movies.json")
            return
        }

        do {
            let movieWrapper = try JSONDecoder().decode(MovieWrapper.self, from: jsonData)
            XCTAssertNotNil(movieWrapper)
            XCTAssertEqual(movieWrapper.page, 1)
            XCTAssertEqual(movieWrapper.totalPages, 993)
            let movies = movieWrapper.results

            XCTAssertNotNil(movies)
            XCTAssertEqual(movies.count, 20)

            let movie = movies.first
            XCTAssertNotNil(movie)
            XCTAssertEqual(movie?.id, 335983)
            XCTAssertEqual(movie?.title, "Venom")
            XCTAssertEqual(movie?.posterPath, "/2uNW4WbgBXL25BAbXGLnLqX71Sw.jpg")
        } catch {
            XCTFail("Decoding error: \(error)")
        }
    }
}
