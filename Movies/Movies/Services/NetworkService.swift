//
//  NetworkService.swift
//  Movies
//
//  Created by Hazim Razak on 20/10/2025.
//

import Foundation

protocol NetworkServiceProtocol {
    func request<T: Decodable>(_ endpoint: TMDBEndpoint, responseType: T.Type) async throws -> T
}

class NetworkService: NetworkServiceProtocol {
    private let baseURL = "https://api.themoviedb.org/3"
    private let apiKey = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkNDVjN2IwNDcxZGFjZGVmYjdmNDA4ODU5YzY0OTE5YSIsIm5iZiI6MTc2MDI0OTkwNS44ODQsInN1YiI6IjY4ZWI0ODMxMzhjYmYwMTdjYjc4NmM3MyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.9kHuP5bedfgG9DHVaFxVrWMHTB11J7o1mOeLg_KeA-Q"

    func request<T: Decodable>(_ endpoint: TMDBEndpoint, responseType: T.Type) async throws -> T {
        guard let url = URL(string: baseURL + endpoint.path) else {
            throw TMDBError.invalidURL
        }

        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        components?.queryItems = endpoint.queryItems

        guard let finalURL = components?.url else {
            throw TMDBError.invalidURL
        }

        var request = URLRequest(url: finalURL)
        request.httpMethod = endpoint.method
        request.setValue("application/json", forHTTPHeaderField: "accept")
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse,
              200..<300 ~= httpResponse.statusCode else {
            throw TMDBError.invalidResponse
        }

        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(T.self, from: data)
        } catch {
            throw TMDBError.invalidData
        }
    }
}
