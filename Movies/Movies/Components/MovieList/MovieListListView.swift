//
//  MovieListListView.swift
//  Movies
//
//  Created by Hazim Razak on 12/10/2025.
//

import SwiftUI

struct MovieListListView: View {
    let listing: Listing
        
    init(listing: Listing, showRating: Bool = false) {
        self.listing = listing
    }
    
    var body: some View {
        HStack(alignment: .center) {
            PosterThumbnailView(posterPath: listing.posterPath ?? "")
                .frame(height: 120)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            VStack(alignment: .leading) {
                Spacer()
                Text("\(listing.title)")
                    .fontWeight(.bold)
                    .lineLimit(2, reservesSpace: false)
                    .padding(4)
                Text("\(listing.releaseDate.prefix(4))")
                    .font(.caption)
                    .padding(4)
//                HStack {
//                    Image(systemName: "star.fill").foregroundStyle(Color.yellow)
//                    Text(String(format: "%.2f", listing.voteAverage))
//                }
//                .font(.caption)
//                .padding(4)
                Spacer()
            }
            .padding(8)
        }
    }

}

#Preview {
    let listing: Listing = Listing(
        id: 1078605,
        popularity: 105.6348,
        posterPath: "/cpf7vsRZ0MYRQcnLWteD5jK9ymT.jpg",
        releaseDate: "2023-01-01",
        title: "Weapons",
        voteAverage: 0,
    )
    
    MovieListListView(listing: listing)
        .frame(width: .infinity, height: 150)
        .padding()
}
