//
//  GenreTagView.swift
//  Movies
//
//  Created by Hazim Razak on 12/10/2025.
//

import SwiftUI

struct GenreTagView: View {
    
    let genre: String
    
    init(genre: String) {
        self.genre = genre
    }
    
    var body: some View {
        Text("\(genre)")
            .padding(8)
            .foregroundStyle(.white)
            .font(.caption)
            .fontWeight(.bold)
            .textCase(.uppercase)
            .background(RoundedRectangle(cornerRadius: 5).fill(GenreColors(rawValue: genre)!.color))
    }
}

#Preview {
    let genre = "Comedy"
    GenreTagView(genre: genre)
}
