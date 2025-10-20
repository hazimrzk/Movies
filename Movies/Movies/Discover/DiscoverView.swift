//
//  DiscoverView.swift
//  Movies
//
//  Created by Hazim Razak on 20/10/2025.
//

import SwiftUI

@MainActor
struct DiscoverView: View {
    @StateObject private var viewModel = DiscoverViewModel()
    
    var body: some View {
        NavigationStack() {
            ScrollView {
                LazyVStack(alignment: .leading) {
                    Text("Action").font(.title).fontWeight(.bold)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(viewModel.actionListings) { listing in
                                NavigationLink {
                                    MovieDetailsView(movieId: listing.id)
                                        .toolbarVisibility(.hidden, for: .tabBar)
                                } label: {
                                    PosterThumbnailView(posterPath: listing.posterPath ?? "")
                                        .frame(height: 210)
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                        .padding(4)
                                }
                                .buttonStyle(.plain)
                            }
                            Rectangle().fill(Color.clear).frame(width: 0, height: 210).padding(0)
                        }
                    }
                    .padding(.bottom)
                    
                    Text("Romance").font(.title).fontWeight(.bold)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(viewModel.romanceListings) { listing in
                                NavigationLink {
                                    MovieDetailsView(movieId: listing.id)
                                        .toolbarVisibility(.hidden, for: .tabBar)
                                } label: {
                                    PosterThumbnailView(posterPath: listing.posterPath ?? "")
                                        .frame(height: 210)
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                        .padding(4)
                                }
                                .buttonStyle(.plain)
                            }
                            Rectangle().fill(Color.clear).frame(width: 0, height: 210).padding(0)
                        }
                    }
                    .padding(.bottom)
                    
                    Text("Animation").font(.title).fontWeight(.bold)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(viewModel.animationListings) { listing in
                                NavigationLink {
                                    MovieDetailsView(movieId: listing.id)
                                        .toolbarVisibility(.hidden, for: .tabBar)
                                } label: {
                                    PosterThumbnailView(posterPath: listing.posterPath ?? "")
                                        .frame(height: 210)
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                        .padding(4)
                                }
                                .buttonStyle(.plain)
                            }
                            Rectangle().fill(Color.clear).frame(width: 0, height: 210).padding(0)
                        }
                    }
                    .padding(.bottom)
                    
                    Text("Horror").font(.title).fontWeight(.bold)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(viewModel.horrorListings) { listing in
                                NavigationLink {
                                    MovieDetailsView(movieId: listing.id)
                                        .toolbarVisibility(.hidden, for: .tabBar)
                                } label: {
                                    PosterThumbnailView(posterPath: listing.posterPath ?? "")
                                        .frame(height: 210)
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                        .padding(4)
                                }
                                .buttonStyle(.plain)
                            }
                            Rectangle().fill(Color.clear).frame(width: 0, height: 210).padding(0)
                        }
                    }
                    .padding(.bottom)
                    
                    Text("Comedy").font(.title).fontWeight(.bold)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(viewModel.comedyListings) { listing in
                                NavigationLink {
                                    MovieDetailsView(movieId: listing.id)
                                        .toolbarVisibility(.hidden, for: .tabBar)
                                } label: {
                                    PosterThumbnailView(posterPath: listing.posterPath ?? "")
                                        .frame(height: 210)
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                        .padding(4)
                                }
                                .buttonStyle(.plain)
                            }
                            Rectangle().fill(Color.clear).frame(width: 0, height: 210).padding(0)
                        }
                    }
                    .padding(.bottom)
                    
                }
                .padding()
            }
            .background(.background)
            .navigationTitle("Genres")
        }
        .task{ await viewModel.taskGetListingsByGenre() }
    }
}

#Preview {
    DiscoverView()
}

