//
//  TMDBServiceTests.swift
//  MoviesTests
//
//  Created by Hazim Razak on 20/10/2025.
//

import Foundation
import XCTest
@testable import Movies

final class TMDBServiceTests: XCTestCase {
    var mockNetwork: MockNetworkService!
    var service: TMDBService!

    override func setUp() {
        super.setUp()
        mockNetwork = MockNetworkService()
        service = TMDBService(network: mockNetwork)
    }

    override func tearDown() {
        mockNetwork = nil
        service = nil
        super.tearDown()
    }
    
    func testGetNowPlayingSuccess() async throws {
        // Arrange
        let json = """
        {
            "page": 1,
            "results": [
                {
                    "id": 1,
                    "popularity": 10.5,
                    "posterPath": "/abc.jpg",
                    "releaseDate": "2025-01-01",
                    "title": "Test Movie",
                    "voteAverage": 7.5
                }
            ],
            "totalPages": 1,
            "totalResults": 1
        }
        """.data(using: .utf8)!
        
        mockNetwork.result = .success(json)

        // Act
        let results = try await service.getNowPlaying(page: 1)

        // Assert
        XCTAssertEqual(results.count, 1)
        await MainActor.run {XCTAssertEqual(results.first?.title, "Test Movie") }
        XCTAssertEqual(mockNetwork.lastEndpoint, .nowPlaying(page: 1))
    }
    
    func testGetNowPlayingInvalidResponse() async {
        // Arrange
        mockNetwork.result = .failure(TMDBError.invalidResponse)

        // Act & Assert
        do {
            _ = try await service.getNowPlaying(page: 1)
            XCTFail("Expected to throw invalidResponse")
        } catch TMDBError.invalidResponse {
            // ✅ Correct error thrown
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func testGetNowPlayingInvalidData() async {
        // Arrange: Broken JSON
        let badJson = "{ \"invalid\": true }".data(using: .utf8)!
        mockNetwork.result = .success(badJson)

        // Act & Assert
        do {
            _ = try await service.getNowPlaying(page: 1)
            XCTFail("Expected invalidData")
        } catch TMDBError.invalidData {
            // ✅ Correct
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
}
