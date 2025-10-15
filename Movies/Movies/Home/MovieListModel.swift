//
//  MovieListModel.swift
//  Movies
//
//  Created by Hazim Razak on 13/10/2025.
//

import Foundation

//MovieList Models

//struct Listing : Codable {
//    let id : Int
//    let adult : Bool
//    let backdropPath : String
//    let genreIds : [Int]
//    let originalLanguage : String
//    let originalTitle : String
//    let overview : String
//    let popularity : Double
//    let posterPath : String
//    let releaseDate : String
//    let title : String
//    let video : Bool
//    let voteAverage : Double
//    let voteCount : Int
//}
//
//struct MovieListings : Codable {
//    let page : Int
//    let results : [Listing]
//    let totalPages : Int
//    let totalResults : Int
//}
//
//enum TMDBError : Error {
//    case invalidURL
//    case invalidResponse
//    case invalidData
//}

//func getMovieListings() async throws -> MovieListings {
//    let rawURLString = "api url"
//    
//    guard let url = URL(string: rawURLString) else {
//        throw TMDBError.invalidURL
//    }
//    
//    let (data, response) = try await URLSession.shared.data(from: url)
//    
//    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
//        throw TMDBError.invalidResponse
//    }
//    
//    do {
//        let decoder = JSONDecoder()
//        decoder.keyDecodingStrategy = .convertFromSnakeCase
//        return try decoder.decode(MovieListings.self, from: data)
//    } catch {
//        throw TMDBError.invalidData
//    }
//}
