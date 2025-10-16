//
//  HomeModel.swift
//  Movies
//
//  Created by Hazim Razak on 13/10/2025.
//

import Foundation

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
