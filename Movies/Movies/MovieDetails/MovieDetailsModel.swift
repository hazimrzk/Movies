//
//  MovieDetailsModel.swift
//  Movies
//
//  Created by Hazim Razak on 13/10/2025.
//

import Foundation

//MovieDetail Models

struct ProductionCompany : Codable {
    let id: Int
    let logoPath: String?
    let name: String
    let originCountry: String
}

//struct ProductionCountry : Codable {
//    let iso31661: String
//    let name: String
//}

struct MovieDetails: Codable {
//    var adult: Bool = false
    var backdropPath: String = ""
//    var belongsToCollection: [Collection]? = nil
//    var budget: Int = 0
    var genres: [Genre] = []
//    var homepage: String = ""
    var id: Int = 0
//    var imdbId: String = ""
//    var originalLanguage: String = ""
//    var originalTitle: String = ""
    var overview: String = ""
    var popularity: Double = 0.0
    var posterPath: String = ""
//    var productionCompanies: [ProductionCompany] = []
//    var productionCountries: [ProductionCountry] = []
//    var releaseDate: String = ""
//    var revenue: Int = 0
    var runtime: Int = 0
    var spokenLanguages: [SpokenLanguage] = []
//    var status: String = ""
//    var tagline: String = ""
    var title: String = ""
//    var video: Bool = false
    var voteAverage: Double = 0.0
//    var voteCount: Int = 0
}

//MovieCast Models

struct Cast : Codable, Identifiable {
//    let adult : Bool
//    let gender : Int
    let id : Int
//    let knownForDepartment : String?
    let name : String
//    let originalName : String
    let popularity : Double
    let profilePath : String?
//    let castId : Int
//    let character : String
//    let creditId : String?
//    let order : Int
}

struct Crew : Codable, Identifiable {
//    let adult : Bool
//    let gender : Int
    let id : Int
//    let known_for_department : String?
    let name : String
//    let original_name : String
//    let popularity : Double
//    let profile_path : String?
//    let credit_id : String?
//    let department : String?
    let job : String
}

struct MovieCredits : Codable {
    let id : Int
    let cast : [Cast]
    let crew : [Crew]
}
