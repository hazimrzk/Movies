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

    private let service: TMDBService = TMDBService()

    func taskGetMovieDetailsAndCredits(movieId: Int) async {
        do {
            movieDetails = try await service.getDetails(id: movieId)
            let credits = try await service.getCredits(id: movieId)
            movieCasts = credits.cast
            movieCrews = credits.crew
        } catch {
            print(error.localizedDescription)
        }
    }
}
