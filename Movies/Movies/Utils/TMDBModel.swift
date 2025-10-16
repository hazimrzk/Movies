//
//  TMDBModel.swift
//  Movies
//
//  Created by Hazim Razak on 15/10/2025.
//

import Foundation

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
