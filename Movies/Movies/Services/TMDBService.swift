//
//  TMDBService.swift
//  Movies
//
//  Created by Hazim Razak on 20/10/2025.
//

import Foundation

class TMDBService {
    private let network: NetworkServiceProtocol

    init(network: NetworkServiceProtocol = NetworkService()) {
        self.network = network
    }

    func getNowPlaying(page: Int) async throws -> [Listing] {
        let response: TMDBListings = try await network.request(.nowPlaying(page: page), responseType: TMDBListings.self)
        return response.results
    }

    func getDetails(id: Int) async throws -> MovieDetails {
        try await network.request(.movieDetails(id: id), responseType: MovieDetails.self)
    }

    func getCredits(id: Int) async throws -> MovieCredits {
        try await network.request(.movieCredits(id: id), responseType: MovieCredits.self)
    }
    
    func getListingsByGenre(genreId: Int) async throws -> [Listing] {
        let response: TMDBListings = try await network.request(.listingsByGenre(genreId: genreId), responseType: TMDBListings.self)
        return response.results
    }
    
    func getListingsByPhrase(phrase: String) async throws -> [Listing] {
        let response: TMDBListings = try await network.request(.searchByPhrase(phrase: phrase), responseType: TMDBListings.self)
        return response.results
    }
}

enum TMDBEndpoint: Equatable {
    case nowPlaying(page: Int)
    case movieDetails(id: Int)
    case movieCredits(id: Int)
    case listingsByGenre(genreId: Int)
    case searchByPhrase(phrase: String)

    var path: String {
        switch self {
        case .nowPlaying:
            return "/movie/now_playing"
        case .movieDetails(let id):
            return "/movie/\(id)"
        case .movieCredits(let id):
            return "/movie/\(id)/credits"
        case .listingsByGenre:
            return "/discover/movie"
        case .searchByPhrase:
            return "/search/movie"
        }
    }
    
    var method: String { "GET" }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .nowPlaying(let page):
            return [
                URLQueryItem(name: "language", value: "en-US"),
                URLQueryItem(name: "page", value: "\(page)")
            ]
        case .movieDetails, .movieCredits:
            return [
                URLQueryItem(name: "language", value: "en-US")
            ]
        case .listingsByGenre(let genreId):
            return [
                URLQueryItem(name: "include_adult", value: "false"),
                URLQueryItem(name: "include_video", value: "false"),
                URLQueryItem(name: "language", value: "en-US"),
                URLQueryItem(name: "page", value: "1"),
                URLQueryItem(name: "sort_by", value: "popularity.desc"),
                URLQueryItem(name: "with_genres", value: "\(genreId)")
            ]
        case .searchByPhrase(let phrase):
            return [
                URLQueryItem(name: "query", value: "\(urlEncode(phrase))"),
                URLQueryItem(name: "include_adult", value: "false"),
                URLQueryItem(name: "language", value: "en-US"),
                URLQueryItem(name: "page", value: "1"),
            ]
        }
    }
}

enum TMDBError : Error {
    case invalidURL
    case invalidResponse
    case invalidData
}

struct TMDBListings : Codable {
    let page : Int
    let results : [Listing]
    let totalPages : Int
    let totalResults : Int
}
