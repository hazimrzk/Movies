//
//  HomeView.swift
//  Movies
//
//  Created by Hazim Razak on 12/10/2025.
//

import SwiftUI

struct HomeView: View {
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    @State var listings : [Listing] = []
    
    var body: some View {
        NavigationStack() {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach (listings) { listing in
                        MovieListTileView(listing: listing).padding(4)
                    }
                }
                .padding()
            }
            .background(.background)
            .navigationTitle("Discover")
        }
        .task {
            do {
                listings = try await getListings()
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
    
    func getListings() async throws -> [Listing] {
        let key = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkNDVjN2IwNDcxZGFjZGVmYjdmNDA4ODU5YzY0OTE5YSIsIm5iZiI6MTc2MDI0OTkwNS44ODQsInN1YiI6IjY4ZWI0ODMxMzhjYmYwMTdjYjc4NmM3MyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.9kHuP5bedfgG9DHVaFxVrWMHTB11J7o1mOeLg_KeA-Q"

//        guard let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing")! else { throw TMDBError.invalidURL }
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing")!
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        let queryItems: [URLQueryItem] = [
          URLQueryItem(name: "language", value: "en-US"),
          URLQueryItem(name: "page", value: "1"),
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
}

struct Listing : Codable,Identifiable, Hashable {
    let id : Int
//    let adult : Bool
//    let backdropPath : String
//    let genreIds : [Int]
//    let originalLanguage : String
//    let originalTitle : String
//    let overview : String
    let popularity : Double
    let posterPath : String?
//    let releaseDate : String
    let title : String
//    let video : Bool
//    let voteAverage : Double
//    let voteCount : Int
}

struct TMDBListings : Codable {
    let page : Int
    let results : [Listing]
    let totalPages : Int
    let totalResults : Int
}

enum TMDBError : Error {
    case invalidURL
    case invalidResponse
    case invalidData
}

#Preview {
    HomeView()
}
