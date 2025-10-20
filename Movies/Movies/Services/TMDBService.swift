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
}

enum TMDBEndpoint: Equatable {
    case nowPlaying(page: Int)
    case movieDetails(id: Int)
    case movieCredits(id: Int)

    var path: String {
        switch self {
        case .nowPlaying:
            return "/movie/now_playing"
        case .movieDetails(let id):
            return "/movie/\(id)"
        case .movieCredits(let id):
            return "/movie/\(id)/credits"
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
