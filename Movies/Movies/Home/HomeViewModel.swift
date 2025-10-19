//
//  HomeViewModel.swift
//  Movies
//
//  Created by Hazim Razak on 15/10/2025.
//

import Foundation
import SwiftUI
import Combine

@MainActor
class HomeViewModel: ObservableObject {
    @Published var listings: [Listing] = []
    @Published var extensionListings: [Listing] = []
    @Published var errorMessage: String?
    @Published var sortType: SortType = .date
    
    private var unsortedListings: [Listing] = []
    
    var currentPage = 1
    
    private func getListings() async throws -> [Listing] {
        let key = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkNDVjN2IwNDcxZGFjZGVmYjdmNDA4ODU5YzY0OTE5YSIsIm5iZiI6MTc2MDI0OTkwNS44ODQsInN1YiI6IjY4ZWI0ODMxMzhjYmYwMTdjYjc4NmM3MyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.9kHuP5bedfgG9DHVaFxVrWMHTB11J7o1mOeLg_KeA-Q"

        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing")!
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        let queryItems: [URLQueryItem] = [
          URLQueryItem(name: "language", value: "en-US"),
          URLQueryItem(name: "page", value: "\(currentPage)"),
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
                
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw TMDBError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let decodedData = try decoder.decode(TMDBListings.self, from: data)
            print(decodedData.results)
            return decodedData.results
        } catch {
            throw TMDBError.invalidData
        }
    }
        
    func taskGetListings() async {
            do {
                listings = try await getListings()
            } catch TMDBError.invalidURL {
                errorMessage = "Invalid URL"
            } catch TMDBError.invalidData {
                errorMessage = "Invalid Data"
            } catch TMDBError.invalidResponse {
                errorMessage = "Invalid Response"
            } catch {
                errorMessage = error.localizedDescription
            }
    }
    
    func taskRefreshListing() async {
            do {
                currentPage = 1
                listings = try await getListings()
            } catch TMDBError.invalidURL {
                errorMessage = "Invalid URL"
            } catch TMDBError.invalidData {
                errorMessage = "Invalid Data"
            } catch TMDBError.invalidResponse {
                errorMessage = "Invalid Response"
            } catch {
                errorMessage = error.localizedDescription
            }
    }
    
    func taskExtendListing() async {
            do {
                currentPage += 1
                extensionListings = try await getListings()
                listings.append(contentsOf: extensionListings)
            } catch TMDBError.invalidURL {
                errorMessage = "Invalid URL"
            } catch TMDBError.invalidData {
                errorMessage = "Invalid Data"
            } catch TMDBError.invalidResponse {
                errorMessage = "Invalid Response"
            } catch {
                errorMessage = error.localizedDescription
            }
    }
    
    func sortChange() {
        switch sortType {
        case .rating:
            listings.sort { $0.voteAverage > $1.voteAverage }
        case .date:
            listings.sort { $0.releaseDate > $1.releaseDate }
        case .title:
            listings.sort { $0.title.localizedCompare($1.title) == .orderedAscending }
        }
    }
}
