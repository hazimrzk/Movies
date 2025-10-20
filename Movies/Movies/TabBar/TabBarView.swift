//
//  TabBarView.swift
//  Movies
//
//  Created by Hazim Razak on 12/10/2025.
//

import SwiftUI

struct TabBarView: View {
    @State var selectedTab: Tabs = .nowPlaying
    @State var searchString = ""
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Tab("Now Playing", systemImage: "popcorn.fill", value: .nowPlaying) {
                HomeView()
            }
            Tab("Genres", systemImage: "theatermasks.fill", value: .genres) {
                DiscoverView()
            }
            Tab(value: .search, role: .search) {
                NavigationStack {
                    List {
                        Text("Search Movies")
                            .foregroundStyle(Color.gray)
                    }
                    .navigationTitle("Search")
                    .searchable(text: $searchString)
                }
            }
        }
    }
}

#Preview {
    TabBarView()
}
