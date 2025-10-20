//
//  SearchResultsView.swift
//  Movies
//
//  Created by Hazim Razak on 20/10/2025.
//

import SwiftUI

struct SearchResultsView: View {
    @State private var searchText = ""
    @StateObject private var viewModel = SearchResultsViewModel()
    
    var body: some View {
        List {
            if viewModel.searchedListings.isEmpty {
                EmptyView()
            } else {
                ForEach(viewModel.searchedListings) { listing in
                    NavigationLink {
                        MovieDetailsView(movieId: listing.id)
                            .toolbarVisibility(.hidden, for: .tabBar)
                    } label: {
                        MovieListListView(listing: listing)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .navigationTitle("Search")
        .searchable(text: $searchText,
                    prompt: "Enter movie title")
        .onSubmit(of: .search) {
            Task {
                await viewModel.taskGetListingsByPhrase(phrase: searchText)
            }
        }
    }
}


#Preview {
    SearchResultsView()
}
