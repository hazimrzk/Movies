//
//  GenreTagModel.swift
//  Movies
//
//  Created by Hazim Razak on 15/10/2025.
//

import Foundation
import SwiftUI

struct Genre : Codable, Identifiable {
    let id: Int
    let name: String
}

enum GenreColors: String, CaseIterable, Identifiable, Decodable {
    case action = "Action"
    case adventure = "Adventure"
    case animation = "Animation"
    case comedy = "Comedy"
    case crime = "Crime"
    case documentary = "Documentary"
    case drama = "Drama"
    case family = "Family"
    case fantasy = "Fantasy"
    case history = "History"
    case horror = "Horror"
    case music = "Music"
    case mystery = "Mystery"
    case romance = "Romance"
    case scienceFiction = "Science Fiction"
    case thriller = "Thriller"
    case tvMovie = "TV Movie"
    case war = "War"
    case western = "Western"

    var id: String { rawValue }
    
    var color: Color {
        switch self {
        case .action:           return .red
        case .adventure:        return .orange
        case .animation:        return .yellow
        case .comedy:           return .mint
        case .crime:            return .gray
        case .documentary:      return .brown
        case .drama:            return .blue
        case .family:           return .teal
        case .fantasy:          return .purple
        case .history:          return .indigo
        case .horror:           return .black
        case .music:            return .red.opacity(0.7)
        case .mystery:          return .cyan
        case .romance:          return .pink
        case .scienceFiction:   return .green
        case .thriller:         return .orange.opacity(0.7)
        case .tvMovie:          return .blue.opacity(0.5)
        case .war:              return .brown.opacity(0.7)
        case .western:          return .yellow.opacity(0.8)
        }
    }
}
