//
//  PosterThumbnailView.swift
//  Movies
//
//  Created by Hazim Razak on 20/10/2025.
//

import SwiftUI

struct PosterThumbnailView: View {
    let posterAspectRatio = CGSize(width: 2, height: 3)
    let baseImageURL = "https://image.tmdb.org/t/p/w500"
    
    let posterPath : String
    
    init(posterPath: String) {
        self.posterPath = posterPath
    }
    
    var body: some View {
        AsyncImage(url: URL(string: baseImageURL + posterPath)) { phase in
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
    }
}

#Preview {
    PosterThumbnailView(posterPath: "/z53D72EAOxGRqdr7KXXWp9dJiDe.jpg")
        .frame(height: 225)
}
