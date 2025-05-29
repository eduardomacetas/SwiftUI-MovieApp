//
//  MovieDetailview.swift
//  SwiftUI-MovieApp
//
//  Created by Eduardo Macetas on 5/28/25.
//

import SwiftUI

struct MovieDetailView: View {
    let movie: Movie
    @EnvironmentObject var favoritesManager: FavoritesManager

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if let posterPath = movie.posterPath {
                    AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")) { image in
                        image.resizable()
                    } placeholder: {
                        Color.gray
                    }
                    .frame(height: 400)
                    .cornerRadius(8)
                }
                HStack {
                    Text(movie.title)
                        .font(.title)
                        .bold()
                    Spacer()
                    Button(action: {
                        if favoritesManager.isFavorite(movie) {
                            favoritesManager.remove(movie)
                        } else {
                            favoritesManager.add(movie)
                        }
                    }) {
                        Image(systemName: favoritesManager.isFavorite(movie) ? "heart.fill" : "heart")
                            .foregroundColor(.red)
                            .imageScale(.large)
                    }
                }
                Text("⭐️ \(String(format: "%.1f", movie.voteAverage))/10")
                    .font(.subheadline)
                Text("Estreno: \(movie.releaseDate ?? "N/A")")
                    .font(.subheadline)
                Text(movie.overview)
                    .font(.body)
            }
            .padding()
        }
        .navigationTitle(movie.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}
