//
//  SearchResultsViewModel.swift
//  Movies
//
//  Created by Hazim Razak on 20/10/2025.
//

import Foundation
import Combine

@MainActor
class SearchResultsViewModel: ObservableObject {
    @Published var errorMessage: String?
    @Published var searchedListings: [Listing] = []
    
    private var service: TMDBService = TMDBService()

    func taskGetListingsByPhrase(phrase: String) async {
        do {
            searchedListings = try await service.getListingsByPhrase(phrase: phrase)
        } catch {
            errorMessage = error.localizedDescription
        }
    }

}
