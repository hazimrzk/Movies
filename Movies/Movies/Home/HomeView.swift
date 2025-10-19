//
//  HomeView.swift
//  Movies
//
//  Created by Hazim Razak on 12/10/2025.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @State private var sortType: SortType = .date

    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationStack() {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach (viewModel.listings) { listing in
                        NavigationLink {
                            MovieDetailsView(movieId: listing.id)
                                .toolbarVisibility(.hidden, for: .tabBar)
                        } label: {
                            MovieListTileView(listing: listing, showRating: true).padding(4)
                        }
                        .buttonStyle(.plain)
                    }
                    Rectangle().fill(Color.clear).frame(height: 0)
                    Rectangle().fill(Color.clear).frame(height: 0)
                        .onAppear {
                            Task {
//                                print("loading new page")
                                await viewModel.taskExtendListing()
                            }
                        }
                }
                .padding()
            }
            .toolbar { ToolbarItem(placement: .navigationBarTrailing) { MenuToolButtonView(sortType: $viewModel.sortType) } }
            .onChange(of: viewModel.sortType, { viewModel.sortChange() })
            .background(.background)
            .navigationTitle("Now Playing")
            .refreshable { await viewModel.taskRefreshListing() }
        }
        .task{ await viewModel.taskGetListings() }
    }
}

#Preview {
    HomeView()
}
