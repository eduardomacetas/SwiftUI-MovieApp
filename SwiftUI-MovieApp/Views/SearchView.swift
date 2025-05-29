//
//  SearchView.swift
//  SwiftUI-MovieApp
//
//  Created by Eduardo Macetas on 5/29/25.
//

import SwiftUI

struct SearchView: View {
    @StateObject private var viewModel = SearchViewModel()
    @State private var hasSearched = false

    var body: some View {
        NavigationView {
            List {
                Section {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.secondary)
                        TextField("Search movie...", text: $viewModel.searchQuery, onCommit: {
                            hasSearched = !viewModel.searchQuery.isEmpty
                        })
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                    }
                    .padding(8)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                }

                if viewModel.isLoading && hasSearched {
                    HStack {
                        Spacer()
                        ProgressView("Loading...")
                        Spacer()
                    }
                } else if let error = viewModel.errorMessage, hasSearched {
                    Text(error)
                        .foregroundColor(.red)
                        .padding()
                } else if hasSearched && !viewModel.movies.isEmpty {
                    ForEach(viewModel.movies) { movie in
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
                } else if hasSearched && viewModel.movies.isEmpty && !viewModel.isLoading && viewModel.errorMessage == nil {
                    Text("No results found.")
                        .foregroundColor(.secondary)
                        .padding()
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Search")
        }
        .onChange(of: viewModel.searchQuery) { newValue in
            hasSearched = !newValue.isEmpty
        }
    }
}
