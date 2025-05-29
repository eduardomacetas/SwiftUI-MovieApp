//
//  MovieListView.swift
//  SwiftUI-MovieApp
//
//  Created by Eduardo Macetas on 5/28/25.
//

import SwiftUI

struct MovieListView: View {
    @StateObject private var viewModel = MovieListViewModel()

    var body: some View {
        NavigationView {
            VStack {
                // Barra de búsqueda
                TextField("Search movie...", text: $viewModel.searchQuery)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                if viewModel.isLoading {
                    ProgressView("Cargando...")
                        .padding()
                } else if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .padding()
                } else {
                    List(viewModel.movies) { movie in
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
                    .listStyle(PlainListStyle())
                }
            }
            .navigationTitle("Popular Movies")
        }
    }
}
