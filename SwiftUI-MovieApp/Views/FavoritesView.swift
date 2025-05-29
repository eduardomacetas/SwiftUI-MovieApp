//
//  FavoritesView.swift
//  SwiftUI-MovieApp
//
//  Created by Eduardo Macetas on 5/28/25.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var favoritesManager: FavoritesManager

    var body: some View {
        NavigationView {
            List(favoritesManager.favorites) { movie in
                NavigationLink(destination: MovieDetailView(movie: movie)) {
                    HStack {
                        if let posterPath = movie.posterPath {
                            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w92\(posterPath)")) { image in
                                image.resizable()
                            } placeholder: {
                                Color.gray
                            }
                            .frame(width: 50, height: 75)
                            .cornerRadius(4)
                        } else {
                            Color.gray
                                .frame(width: 50, height: 75)
                                .cornerRadius(4)
                        }
                        VStack(alignment: .leading) {
                            Text(movie.title)
                                .font(.headline)
                            Text(movie.releaseDate ?? "")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
            .navigationTitle("Favorites")
        }
    }
}
