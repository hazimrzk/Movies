//
//  DiscoverViewModel.swift
//  Movies
//
//  Created by Hazim Razak on 20/10/2025.
//

import Foundation
import Combine

@MainActor
class DiscoverViewModel: ObservableObject {
    @Published var errorMessage: String?
    @Published var actionListings: [Listing] = []
    @Published var horrorListings: [Listing] = []
    @Published var comedyListings: [Listing] = []
    @Published var animationListings: [Listing] = []
    @Published var romanceListings: [Listing] = []

    private var service: TMDBService = TMDBService()

    func taskGetListingsByGenre() async {
        do {
            actionListings = try await service.getListingsByGenre(genreId: 28)
            horrorListings = try await service.getListingsByGenre(genreId: 27)
            comedyListings = try await service.getListingsByGenre(genreId: 35)
            animationListings = try await service.getListingsByGenre(genreId: 16)
            romanceListings = try await service.getListingsByGenre(genreId: 10749)
        } catch {
            errorMessage = error.localizedDescription
        }
    }

}
