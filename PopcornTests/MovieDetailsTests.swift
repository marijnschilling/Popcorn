//
// Created by Marijn Schilling on 04/12/2018.
// Copyright (c) 2018 Marijn Schilling. All rights reserved.
//

import XCTest
@testable import Popcorn

class MovieDetailsTests: XCTestCase {
    var testDate: Date {
        var dateComponents = DateComponents()
        dateComponents.year = 2018
        dateComponents.month = 11
        dateComponents.day = 14
        dateComponents.hour = 00
        dateComponents.minute = 00

        return Calendar.current.date(from: dateComponents)!
    }

    func testMoviesJSONMapping() {
        let bundle = Bundle(for: type(of: self))

        guard let url = bundle.url(forResource: "MovieDetails", withExtension: "json") else {
            XCTFail("Missing file: MovieDetails.json")
            return
        }

        guard let jsonData = try? Data(contentsOf: url) else {
            XCTFail("Corrupt file: MovieDetails.json")
            return
        }

        do {
            let movieDetails = try JSONDecoder.movieDetailsDecoder.decode(MovieDetails.self, from: jsonData)
            XCTAssertNotNil(movieDetails)
            XCTAssertEqual(movieDetails.title, "Fantastic Beasts: The Crimes of Grindelwald")
            XCTAssertEqual(movieDetails.tagline, "Fate of One. Future of All.")
            XCTAssertEqual(movieDetails.overview, "Gellert Grindelwald has escaped imprisonment and has begun gathering followers to his cause—elevating wizards above all non-magical beings. The only one capable of putting a stop to him is the wizard he once called his closest friend, Albus Dumbledore. However, Dumbledore will need to seek help from the wizard who had thwarted Grindelwald once before, his former student Newt Scamander, who agrees to help, unaware of the dangers that lie ahead. Lines are drawn as love and loyalty are tested, even among the truest friends and family, in an increasingly divided wizarding world.")
            XCTAssertEqual(movieDetails.releaseDate, testDate)
            XCTAssertEqual(movieDetails.voteAverage, 7)
            XCTAssertEqual(movieDetails.posterPath, "/uyJgTzAsp3Za2TaPiZt2yaKYRIR.jpg")
            XCTAssertEqual(movieDetails.backdropPath, "/xgbeBCjmFpRYHDF7tQ7U98EREWp.jpg")
        } catch {
            XCTFail("Decoding error: \(error)")
        }
    }
}
