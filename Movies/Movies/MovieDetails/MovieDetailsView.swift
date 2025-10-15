//
//  MovieDetailsView.swift
//  Movies
//
//  Created by Hazim Razak on 12/10/2025.
//

import SwiftUI

struct MovieDetailsView: View {
    let movieId: String
    let backdropAspectRatio = CGSize(width: 16, height: 9)

    
    @State var movieDetails: MovieDetails = MovieDetails()
    @State var movieCasts: [Cast] = []
    @State var movieCrews: [Crew] = []
    
    init(movieId: String) {
        self.movieId = movieId
    }
    
    var body: some View {
        NavigationStack() {
            ScrollView {
                LazyVStack(alignment: .leading) {
                    AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(movieDetails.backdropPath)")) { phase in
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
                    Text("\(movieDetails.title)")
                        .font(.title)
                        .bold()
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(){
                            ForEach(movieDetails.genres) { genre in
                                GenreTagView(genre: genre.name)
                            }
                        }
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                    .padding(.horizontal)
                    .padding(.vertical, 8)

                    HStack(alignment: .center){
                        ForEach(movieDetails.spokenLanguages, id: \.self) { lang in
                            LanguageTagView(language: lang.iso6391)
                        }
                        Image(systemName: "clock.fill")
                            .foregroundStyle(Color.gray)
                            .font(.caption)
                        Text("\(movieDetails.runtime/60) HR \(movieDetails.runtime%60) MINS")
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
                                .frame(width: CGFloat(movieDetails.voteAverage*10))
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
                    Text(movieDetails.overview)
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
                            ForEach(movieCasts.prefix(7)) { cast in
                                MovieListTileView(listing: Listing(id: cast.id, popularity: cast.popularity, posterPath: cast.profilePath, title: cast.name))
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
    //                    RoundedRectangle(cornerRadius: 8)
    //                        .fill(Color(.secondarySystemBackground))
                        LazyVStack {
                            ForEach(movieCrews.prefix(7).enumerated(), id: \.element.id){ index, crew in
                                index == 0 ? nil : Divider()
                                HStack{
                                    Text(crew.name).font(.subheadline)
                                    Spacer()
                                    Text(crew.job).font(.subheadline).italic().opacity(0.75)
                                }
                            }
                        }
    //                    .padding()
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                }
            }
    //        .ignoresSafeArea()
            .safeAreaInset(edge: .bottom){
                BottomButtonBar()
            }
            .navigationTitle(movieDetails.title)
            .navigationBarTitleDisplayMode(.inline)
            .task {
                do {
                    movieDetails = try await getDetails()
                    (movieCasts, movieCrews) = try await getCredits()
                } catch TMDBError.invalidURL {
                    print("Invalid URL")
                } catch TMDBError.invalidData {
                    print("Invalid Data")
                } catch TMDBError.invalidResponse {
                    print("Invalid Response")
                } catch {
                    print("Unknown error: \(error)")
                }
            }
        }
    }
    
    func getDetails() async throws -> MovieDetails {
        let key = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkNDVjN2IwNDcxZGFjZGVmYjdmNDA4ODU5YzY0OTE5YSIsIm5iZiI6MTc2MDI0OTkwNS44ODQsInN1YiI6IjY4ZWI0ODMxMzhjYmYwMTdjYjc4NmM3MyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.9kHuP5bedfgG9DHVaFxVrWMHTB11J7o1mOeLg_KeA-Q"

        let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieId)")!
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        let queryItems: [URLQueryItem] = [
          URLQueryItem(name: "language", value: "en-US"),
        ]
        components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems

        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
          "accept": "application/json",
          "Authorization": "Bearer \(key)"
        ]

        let (data, response) = try await URLSession.shared.data(for: request)
        print(String(decoding: data, as: UTF8.self))
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw TMDBError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let decodedData = try decoder.decode(MovieDetails.self, from: data)
            printPretty(decodedData)
            return decodedData
        } catch {
            throw TMDBError.invalidData
        }
    }
    
    func getCredits() async throws -> ([Cast], [Crew]) {
        let key = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkNDVjN2IwNDcxZGFjZGVmYjdmNDA4ODU5YzY0OTE5YSIsIm5iZiI6MTc2MDI0OTkwNS44ODQsInN1YiI6IjY4ZWI0ODMxMzhjYmYwMTdjYjc4NmM3MyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.9kHuP5bedfgG9DHVaFxVrWMHTB11J7o1mOeLg_KeA-Q"

        let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieId)/credits")!
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        let queryItems: [URLQueryItem] = [
          URLQueryItem(name: "language", value: "en-US"),
        ]
        components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems

        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
          "accept": "application/json",
          "Authorization": "Bearer \(key)"
        ]

        let (data, response) = try await URLSession.shared.data(for: request)
        print(String(decoding: data, as: UTF8.self))
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw TMDBError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let decodedData = try decoder.decode(MovieCredits.self, from: data)
            printPretty(decodedData.cast)
            printPretty(decodedData.crew)
            return (decodedData.cast, decodedData.crew)
        } catch {
            throw TMDBError.invalidData
        }
    }
}

#Preview {
    let movieId = "1054867"
//    let movieId = "1038392"

    
    MovieDetailsView(movieId: movieId)
}
