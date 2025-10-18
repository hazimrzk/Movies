//
//  MovieListTileView.swift
//  Movies
//
//  Created by Hazim Razak on 12/10/2025.
//

import SwiftUI

struct MovieListTileView: View {
    let posterAspectRatio = CGSize(width: 2, height: 3)
    let baseImageURL = "https://image.tmdb.org/t/p/w500"
    let placeholderImage = "poster"
    
    let listing: Listing
    
    var showRating: Bool
    
    init(listing: Listing, showRating: Bool = false) {
        self.listing = listing
        self.showRating = showRating
    }
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            ZStack(alignment: .bottom) {
                AsyncImage(url: URL(string: listing.posterPath.map { baseImageURL + $0 } ?? "")) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .aspectRatio(posterAspectRatio, contentMode: .fit)
                            .overlay(LinearGradient(gradient: Gradient(colors: [.clear, .black]), startPoint: .top, endPoint: .bottom).opacity(0.5))
                    } else if phase.error != nil {
                        Rectangle()
                            .fill(Color(.secondarySystemBackground))
                            .overlay(Image(systemName: "exclamationmark.triangle.fill"))
                            .aspectRatio(posterAspectRatio, contentMode: .fit)
                    } else {
                        Rectangle()
                            .fill(Color(.secondarySystemBackground))
                            .overlay(ProgressView())
                            .aspectRatio(posterAspectRatio, contentMode: .fit)
                    }
                }
                HStack {
                    Spacer()
                    Text("\(Int(listing.popularity))")
                        .foregroundStyle(Color.white)
                        .font(.caption2)
                        .fontWeight(.bold)
                    Image(systemName: "chart.line.uptrend.xyaxis")
                        .foregroundStyle(Color.white)
                        .font(.caption2)
                }
                .padding(8)
                .opacity(showRating ? 0.85 : 0.0)
            }
            Text("\(listing.title)")
                .font(.subheadline)
                .lineLimit(2, reservesSpace: true)
                .padding(12)
        }
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

#Preview {
    
    let listing: Listing = Listing(
        id: 1078605,
        popularity: 105.6348,
        posterPath: "/cpf7vsRZ0MYRQcnLWteD5jK9ymT.jpg",
        title: "Weapons"
    )
    
    MovieListTileView(listing: listing, showRating: true)
        .frame(width: 150)
}
