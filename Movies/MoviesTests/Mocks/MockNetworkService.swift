//
//  MockNetworkService.swift
//  MoviesTests
//
//  Created by Hazim Razak on 20/10/2025.
//

import Foundation
@testable import Movies

class MockNetworkService: NetworkServiceProtocol {
    var result: Result<Data, Error>!
    var lastEndpoint: TMDBEndpoint?
    var decoder = JSONDecoder()
    
    init() {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    func request<T>(_ endpoint: TMDBEndpoint, responseType: T.Type) async throws -> T where T : Decodable {
        lastEndpoint = endpoint
        
        switch result {
        case .success(let data):
            do {
                return try decoder.decode(T.self, from: data)
            } catch {
                throw TMDBError.invalidData
            }
        case .failure(let error):
            throw error
        case .none:
            fatalError("MockNetworkService result not set")
        }
    }
}
