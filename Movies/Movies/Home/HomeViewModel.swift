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
    @Published var errorMessage: String?
    @Published var sortType: SortType = .date

    private var service: TMDBService = TMDBService()
    private var currentPage = 1

    func taskGetListings() async {
        do {
            listings = try await service.getNowPlaying(page: currentPage)
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    func taskRefreshListing() async {
        currentPage = 1
        await taskGetListings()
    }

    func taskExtendListing() async {
        currentPage += 1
        do {
            let more = try await service.getNowPlaying(page: currentPage)
            listings.append(contentsOf: more)
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
