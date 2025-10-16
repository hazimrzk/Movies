//
//  HomeView.swift
//  Movies
//
//  Created by Hazim Razak on 12/10/2025.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
        
    var body: some View {
        NavigationStack() {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach (viewModel.listings) { listing in
                        MovieListTileView(listing: listing).padding(4)
                    }
                }
                .padding()
            }
            .background(.background)
            .navigationTitle("Discover")
        }
        .task{ await viewModel.taskGetListings() }
    }
}

#Preview {
    HomeView()
}
