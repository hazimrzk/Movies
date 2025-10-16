//
//  MovieDetailsViewModel.swift
//  Movies
//
//  Created by Hazim Razak on 15/10/2025.
//

import Foundation
import SwiftUI
import Combine

@MainActor
class MovieDetailsViewModel: ObservableObject {
    @Published var movieDetails: MovieDetails = MovieDetails()
    @Published var movieCasts: [Cast] = []
    @Published var movieCrews: [Crew] = []
    
    private func getDetails(movieId: Int) async throws -> MovieDetails {
        let key = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkNDVjN2IwNDcxZGFjZGVmYjdmNDA4ODU5YzY0OTE5YSIsIm5iZiI6MTc2MDI0OTkwNS44ODQsInN1YiI6IjY4ZWI0ODMxMzhjYmYwMTdjYjc4NmM3MyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.9kHuP5bedfgG9DHVaFxVrWMHTB11J7o1mOeLg_KeA-Q"

        let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieId)")!
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        let queryItems: [URLQueryItem] = [
          URLQueryItem(name: "language", value: "en-US"),
        ]
        components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems

        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
          "accept": "application/json",
          "Authorization": "Bearer \(key)"
        ]

        let (data, response) = try await URLSession.shared.data(for: request)
        print(String(decoding: data, as: UTF8.self))
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw TMDBError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let decodedData = try decoder.decode(MovieDetails.self, from: data)
            printPretty(decodedData)
            return decodedData
        } catch {
            throw TMDBError.invalidData
        }
        
    }
    
    private func getCredits(movieId: Int) async throws -> ([Cast], [Crew]) {
        let key = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkNDVjN2IwNDcxZGFjZGVmYjdmNDA4ODU5YzY0OTE5YSIsIm5iZiI6MTc2MDI0OTkwNS44ODQsInN1YiI6IjY4ZWI0ODMxMzhjYmYwMTdjYjc4NmM3MyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.9kHuP5bedfgG9DHVaFxVrWMHTB11J7o1mOeLg_KeA-Q"

        let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieId)/credits")!
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        let queryItems: [URLQueryItem] = [
          URLQueryItem(name: "language", value: "en-US"),
        ]
        components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems

        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
          "accept": "application/json",
          "Authorization": "Bearer \(key)"
        ]

        let (data, response) = try await URLSession.shared.data(for: request)
        print(String(decoding: data, as: UTF8.self))
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw TMDBError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let decodedData = try decoder.decode(MovieCredits.self, from: data)
            printPretty(decodedData.cast)
            printPretty(decodedData.crew)
            return (decodedData.cast, decodedData.crew)
        } catch {
            throw TMDBError.invalidData
        }
    }
    
    func taskGeMovieDetailsAndCredits(movieId: Int) async {
        do {
            movieDetails = try await getDetails(movieId: movieId)
            (movieCasts, movieCrews) = try await getCredits(movieId: movieId)
        } catch TMDBError.invalidURL {
            print("Invalid URL")
        } catch TMDBError.invalidData {
            print("Invalid Data")
        } catch TMDBError.invalidResponse {
            print("Invalid Response")
        } catch {
            print("Unknown error: \(error)")
        }
    }
    
}
