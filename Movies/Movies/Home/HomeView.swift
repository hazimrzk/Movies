//
//  HomeView.swift
//  Movies
//
//  Created by Hazim Razak on 12/10/2025.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @State private var columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationStack() {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach (viewModel.listings) { listing in
                        NavigationLink {
                            MovieDetailsView(movieId: listing.id)
                                .toolbarVisibility(.hidden, for: .tabBar)
                        } label: {
                            switch viewModel.listType {
                                case .icon:
                                    MovieListTileView(listing: listing, showRating: true).padding(4)
                                case .list:
                                    HStack {
                                        MovieListListView(listing: listing, showRating: true).frame(height: 130).padding(0)
                                        Spacer()
                                    }
                            }
                        }
                        .buttonStyle(.plain)
                    }
                    Rectangle().fill(Color.clear).frame(height: 0)
                    Rectangle().fill(Color.clear).frame(height: 0)
                        .onAppear {
                            Task {
                                await viewModel.taskExtendListing()
                            }
                        }
                }
                .padding()
            }
            .toolbar { ToolbarItem(placement: .navigationBarTrailing) { MenuToolButtonView(sortType: $viewModel.sortType, listType: $viewModel.listType, column: $columns) } }
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
