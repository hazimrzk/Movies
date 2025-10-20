//
//  UtilsTests.swift
//  MoviesTests
//
//  Created by Hazim Razak on 20/10/2025.
//

import XCTest

@testable import Movies

final class URLEncodeTests: XCTestCase {

    func testUrlEncode_withSpaces() {
        let input = "hello world"
        let expected = "hello%20world"
        XCTAssertEqual(urlEncode(input), expected)
    }

    func testUrlEncode_withSpecialCharacters() {
        let input = "a+b&c=d"
        let expected = "a+b&c=d".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        XCTAssertEqual(urlEncode(input), expected)
    }

    func testUrlEncode_emptyString() {
        XCTAssertEqual(urlEncode(""), "")
    }

    func testUrlEncode_noEncodingNeeded() {
        XCTAssertEqual(urlEncode("abc123"), "abc123")
    }
}
