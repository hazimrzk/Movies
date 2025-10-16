//
//  MovieDetailsView.swift
//  Movies
//
//  Created by Hazim Razak on 12/10/2025.
//

import SwiftUI

struct MovieDetailsView: View {
    @StateObject private var viewModel = MovieDetailsViewModel()
    let movieId: Int
    let backdropAspectRatio = CGSize(width: 16, height: 9)
    
    init(movieId: Int) {
        self.movieId = movieId
    }
    
    var body: some View {
        NavigationStack() {
            ScrollView {
                LazyVStack(alignment: .leading) {
                    AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(viewModel.movieDetails.backdropPath)")) { phase in
                        if let image = phase.image {
                            image
                                .resizable()
                                .aspectRatio(backdropAspectRatio, contentMode: .fit)
                                .overlay(
                                    VStack{
                                        LinearGradient(gradient: Gradient(colors: [Color(.systemBackground), .clear]), startPoint: .top, endPoint: .bottom)
                                        Rectangle().fill(Color.clear)
                                    }
                                )
                        } else if phase.error != nil {
                            Rectangle()
                                .fill(Color(.secondarySystemBackground))
                                .overlay(Image(systemName: "exclamationmark.triangle.fill"))
                                .aspectRatio(backdropAspectRatio, contentMode: .fit)
                        } else {
                            Rectangle()
                                .fill(Color(.secondarySystemBackground))
                                .overlay(ProgressView())
                                .aspectRatio(backdropAspectRatio, contentMode: .fit)
                        }
                    }
                    Text("\(viewModel.movieDetails.title)")
                        .font(.title)
                        .bold()
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(){
                            ForEach(viewModel.movieDetails.genres) { genre in
                                GenreTagView(genre: genre.name)
                            }
                        }
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                    .padding(.horizontal)
                    .padding(.vertical, 8)

                    HStack(alignment: .center){
                        ForEach(viewModel.movieDetails.spokenLanguages, id: \.self) { lang in
                            LanguageTagView(language: lang.iso6391)
                        }
                        Image(systemName: "clock.fill")
                            .foregroundStyle(Color.gray)
                            .font(.caption)
                        Text("\(viewModel.movieDetails.runtime/60) HR \(viewModel.movieDetails.runtime%60) MINS")
                            .font(.caption)
                            .textCase(.uppercase)
    //                    Spacer()
    //                    Image(systemName: "star.fill")
    //                        .foregroundStyle(Color.gray)
    //                        .font(.caption)
    //                    Text("4.00")
    //                        .font(.caption)
    //                        .textCase(.uppercase)
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    //Synopsis
                    HStack {
                        Text("Overview")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .textCase(.uppercase)
                        Spacer()
                        ZStack(alignment: .leading) {
                            Rectangle()
                                .fill(Color.gray)
                                .frame(width: 100)
                            Rectangle()
                                .fill(Color.yellow)
                                .frame(width: CGFloat(viewModel.movieDetails.voteAverage*10))
                        }
                        .mask(
                            HStack(spacing: 8) {
                                Image(systemName: "star.fill").resizable().scaledToFit()
                                Image(systemName: "star.fill").resizable().scaledToFit()
                                Image(systemName: "star.fill").resizable().scaledToFit()
                                Image(systemName: "star.fill").resizable().scaledToFit()
                                Image(systemName: "star.fill").resizable().scaledToFit()
                            }
                        )
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    Text(viewModel.movieDetails.overview)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color(.secondarySystemBackground))
                        )
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                    Text("Cast")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .textCase(.uppercase)
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack {
                            ForEach(viewModel.movieCasts.prefix(7)) { cast in
                                MovieListTileView(listing: Listing(
                                    id: cast.id,
                                    popularity: cast.popularity,
                                    posterPath: cast.profilePath,
                                    title: cast.name))
                                .frame(width: 140)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                    }
                    Text("Credits")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .textCase(.uppercase)
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                    ZStack {
                        LazyVStack {
                            ForEach(viewModel.movieCrews.prefix(7).enumerated(), id: \.element.id){ index, crew in
                                index == 0 ? nil : Divider()
                                HStack{
                                    Text(crew.name).font(.subheadline)
                                    Spacer()
                                    Text(crew.job).font(.subheadline).italic().opacity(0.75)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                }
            }
            .safeAreaInset(edge: .bottom){ BottomButtonBar() }
            .navigationTitle(viewModel.movieDetails.title)
            .navigationBarTitleDisplayMode(.inline)
            .task { await viewModel.taskGeMovieDetailsAndCredits(movieId: movieId)}
        }
    }
}

#Preview {
    let movieId = 1054867
//  1038392 1054867
    MovieDetailsView(movieId: movieId)
}
