//
//  VizioMoviesTests.swift
//  VizioMoviesTests
//
//  Created by Noah Bragg on 8/15/19.
//  Copyright © 2019 Noah Bragg. All rights reserved.
//

import XCTest
@testable import VizioMovies

class VizioMoviesTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testMoviesEndpoint() {
        ApiHelper.fetchMovies(searchPhrase: "Star Wars", onComplete: { movies in
            XCTAssertGreaterThan(movies.count, 0)
        })
    }

    func testReviewEndpoint() {
        ApiHelper.fetchReviews(movieId: 245891, onComplete: { reviews in
            XCTAssertGreaterThan(reviews.count, 0)
        })
    }

}
