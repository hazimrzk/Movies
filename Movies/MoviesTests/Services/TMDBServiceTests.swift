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
                    "id": 575265,
                    "popularity": 147.1501,
                    "posterPath": "/z53D72EAOxGRqdr7KXXWp9dJiDe.jpg",
                    "releaseDate": "2025-05-17",
                    "title": "Mission: Impossible - The Final Reckoning",
                    "voteAverage": 7.273
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
        await MainActor.run {XCTAssertEqual(results.first?.title, "Mission: Impossible - The Final Reckoning") }
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
    
    func testGetDetailsSuccess() async throws {
        // Arrange
        let json = """
        {
          "adult": false,
          "backdrop_path": "/zvOJawrnmgK0sL293mOXOdLvTXQ.jpg",
          "belongs_to_collection": {
            "id": 1401402,
            "name": "Call Me by Your Name Collection",
            "poster_path": "/94DW591sFWh6kcNyuiHMgRrllFi.jpg",
            "backdrop_path": "/baLoLeFw58xMGSuxaVUinBe4Y3b.jpg"
          },
          "budget": 3500000,
          "genres": [
            {
              "id": 10749,
              "name": "Romance"
            },
            {
              "id": 18,
              "name": "Drama"
            }
          ],
          "homepage": "http://sonyclassics.com/callmebyyourname/",
          "id": 398818,
          "imdb_id": "tt5726616",
          "origin_country": [
            "US"
          ],
          "original_language": "en",
          "original_title": "Call Me by Your Name",
          "overview": "In the summer of 1983, a 17-year-old Elio spends his days in his family's villa in Italy. One day Oliver, a graduate student, arrives to assist Elio's father, a professor of Greco-Roman culture. Soon, Elio and Oliver discover a summer that will alter their lives forever.",
          "popularity": 8.9346,
          "poster_path": "/mZ4gBdfkhP9tvLH1DO4m4HYtiyi.jpg",
          "production_companies": [
            {
              "id": 16017,
              "logo_path": null,
              "name": "La Cinéfacture",
              "origin_country": "FR"
            }
          ],
          "production_countries": [
            {
              "iso_3166_1": "IT",
              "name": "Italy"
            }
          ],
          "release_date": "2017-07-28",
          "revenue": 43143046,
          "runtime": 132,
          "spoken_languages": [
            {
              "english_name": "English",
              "iso_639_1": "en",
              "name": "English"
            }
          ],
          "status": "Released",
          "tagline": "Is it better to speak or die?",
          "title": "Call Me by Your Name",
          "video": false,
          "vote_average": 8.107,
          "vote_count": 12455
        }
        """.data(using: .utf8)!
        
        mockNetwork.result = .success(json)

        // Act
        let details = try await service.getDetails(id: 398818)

        // Assert
        await MainActor.run { XCTAssertEqual(details.voteAverage, 8.107) }
        XCTAssertEqual(mockNetwork.lastEndpoint, .movieDetails(id: 398818))
    }
    
    func testGetDetailsInvalidResponse() async {
        // Arrange
        mockNetwork.result = .failure(TMDBError.invalidResponse)

        // Act & Assert
        do {
            _ = try await service.getDetails(id: 398818)
            XCTFail("Expected to throw invalidResponse")
        } catch TMDBError.invalidResponse {
            // ✅ Correct error thrown
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func testGetDetailsInvalidData() async {
        // Arrange: Broken JSON
        let badJson = "{ \"invalid\": true }".data(using: .utf8)!
        mockNetwork.result = .success(badJson)

        // Act & Assert
        do {
            _ = try await service.getDetails(id: 398818)
            XCTFail("Expected invalidData")
        } catch TMDBError.invalidData {
            // ✅ Correct
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func testGetCreditsSuccess() async throws {
        // Arrange
        let json = """
        {
          "id": 1054867,
          "cast": [
            {
              "adult": false,
              "gender": 2,
              "id": 6193,
              "known_for_department": "Acting",
              "name": "Leonardo DiCaprio",
              "original_name": "Leonardo DiCaprio",
              "popularity": 6.4098,
              "profile_path": "/wo2hJpn04vbtmh0B9utCFdsQhxM.jpg",
              "cast_id": 4,
              "character": "Bob",
              "credit_id": "644255edb3f6f505269de56b",
              "order": 0
            }
          ],
          "crew": [
            {
              "adult": false,
              "gender": 1,
              "id": 1236222,
              "known_for_department": "Production",
              "name": "Sara Murphy",
              "original_name": "Sara Murphy",
              "popularity": 0.0719,
              "profile_path": "/iN0fNPsNfCJc2tBIztXZC13nA9O.jpg",
              "credit_id": "659edd1cd6590b01fdaf95fa",
              "department": "Production",
              "job": "Producer"
            }
          ]
        }
        """.data(using: .utf8)!
        
        mockNetwork.result = .success(json)

        // Act
        let credits = try await service.getCredits(id: 1054867)

        // Assert
        await MainActor.run { XCTAssertEqual(credits.cast.first?.name, "Leonardo DiCaprio") }
        XCTAssertEqual(mockNetwork.lastEndpoint, .movieCredits(id: 1054867))
    }
    
    func testGetCreditsInvalidResponse() async {
        // Arrange
        mockNetwork.result = .failure(TMDBError.invalidResponse)

        // Act & Assert
        do {
            _ = try await service.getCredits(id: 1054867)
            XCTFail("Expected to throw invalidResponse")
        } catch TMDBError.invalidResponse {
            // ✅ Correct error thrown
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func testGetCreditsInvalidData() async {
        // Arrange: Broken JSON
        let badJson = "{ \"invalid\": true }".data(using: .utf8)!
        mockNetwork.result = .success(badJson)

        // Act & Assert
        do {
            _ = try await service.getCredits(id: 1054867)
            XCTFail("Expected invalidData")
        } catch TMDBError.invalidData {
            // ✅ Correct
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func testGetListingByGenreSuccess() async throws {
        // Arrange
        let json = """
        {
            "page": 1,
            "results": [
                {
                    "id": 575265,
                    "popularity": 147.1501,
                    "posterPath": "/z53D72EAOxGRqdr7KXXWp9dJiDe.jpg",
                    "releaseDate": "2025-05-17",
                    "title": "Mission: Impossible - The Final Reckoning",
                    "voteAverage": 7.273
                }
            ],
            "totalPages": 1,
            "totalResults": 1
        }
        """.data(using: .utf8)!
        
        mockNetwork.result = .success(json)

        // Act
        let results = try await service.getListingsByGenre(genreId: 28)

        // Assert
        XCTAssertEqual(results.count, 1)
        await MainActor.run {XCTAssertEqual(results.first?.title, "Mission: Impossible - The Final Reckoning") }
        XCTAssertEqual(mockNetwork.lastEndpoint, .listingsByGenre(genreId: 28))
    }
    
    func testGetListingByGenreInvalidResponse() async {
        // Arrange
        mockNetwork.result = .failure(TMDBError.invalidResponse)

        // Act & Assert
        do {
            _ = try await service.getListingsByGenre(genreId: 28)
            XCTFail("Expected to throw invalidResponse")
        } catch TMDBError.invalidResponse {
            // ✅ Correct error thrown
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func testGetListingByGenreInvalidData() async {
        // Arrange: Broken JSON
        let badJson = "{ \"invalid\": true }".data(using: .utf8)!
        mockNetwork.result = .success(badJson)

        // Act & Assert
        do {
            _ = try await service.getListingsByGenre(genreId: 28)
            XCTFail("Expected invalidData")
        } catch TMDBError.invalidData {
            // ✅ Correct
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func testGetListingByPhraseSuccess() async throws {
        // Arrange
        let json = """
        {
            "page": 1,
            "results": [
                {
                    "id": 671,
                    "popularity": 34.6164,
                    "posterPath": "/wuMc08IPKEatf9rnMNXvIDxqP4W.jpg",
                    "releaseDate": "2001-11-16",
                    "title": "Harry Potter and the Philosopher's Stone",
                    "voteAverage": 7.9
                }
            ],
            "totalPages": 1,
            "totalResults": 1
        }
        """.data(using: .utf8)!
        
        mockNetwork.result = .success(json)

        // Act
        let results = try await service.getListingsByPhrase(phrase: "Harry Potter")

        // Assert
        XCTAssertEqual(results.count, 1)
        await MainActor.run {XCTAssertEqual(results.first?.title, "Harry Potter and the Philosopher's Stone") }
        XCTAssertEqual(mockNetwork.lastEndpoint, .searchByPhrase(phrase: "Harry Potter"))
    }
    
    func testGetListingByPhraseInvalidResponse() async {
        // Arrange
        mockNetwork.result = .failure(TMDBError.invalidResponse)

        // Act & Assert
        do {
            _ = try await service.getListingsByPhrase(phrase: "Harry Potter")
            XCTFail("Expected to throw invalidResponse")
        } catch TMDBError.invalidResponse {
            // ✅ Correct error thrown
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func testGetListingByPhraseInvalidData() async {
        // Arrange: Broken JSON
        let badJson = "{ \"invalid\": true }".data(using: .utf8)!
        mockNetwork.result = .success(badJson)

        // Act & Assert
        do {
            _ = try await service.getListingsByPhrase(phrase: "Harry Potter")
            XCTFail("Expected invalidData")
        } catch TMDBError.invalidData {
            // ✅ Correct
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }

    
}
