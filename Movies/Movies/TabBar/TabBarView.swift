//
//  TabBarView.swift
//  Movies
//
//  Created by Hazim Razak on 12/10/2025.
//

import SwiftUI

enum Tabs {
    case discover, favorites, bookings, search
}

struct TabBarView: View {
    @State var selectedTab: Tabs = .discover
    @State var searchString = ""
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Tab("Discover", systemImage: "paperplane", value: .discover) {
                HomeView()
            }
//            Tab("Favorites", systemImage: "heart", value: .discover) {
//                MovieDetailsView()
//            }
//            Tab("Bookings", systemImage: "ticket.fill", value: .discover) {
//                MovieDetailsView()
//            }
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
