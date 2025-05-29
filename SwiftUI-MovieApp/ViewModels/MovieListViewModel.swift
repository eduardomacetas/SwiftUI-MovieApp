//
//  MovieListViewModel.swift
//  SwiftUI-MovieApp
//
//  Created by Eduardo Macetas on 5/28/25.
//

import Foundation
import Combine

class MovieListViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var searchQuery: String = ""

    private let apiService = MovieAPIService()
    private var cancellables = Set<AnyCancellable>()

    init() {
        fetchPopularMovies()
        setupSearch()
    }

    func fetchPopularMovies() {
        isLoading = true
        errorMessage = nil
        apiService.fetchPopularMovies { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let movies):
                    self?.movies = movies
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }

    func searchMovies(query: String) {
        guard !query.isEmpty else {
            fetchPopularMovies()
            return
        }
        isLoading = true
        errorMessage = nil
        apiService.searchMovies(query: query) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let movies):
                    self?.movies = movies
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }

    private func setupSearch() {
        $searchQuery
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] query in
                self?.searchMovies(query: query)
            }
            .store(in: &cancellables)
    }
}
