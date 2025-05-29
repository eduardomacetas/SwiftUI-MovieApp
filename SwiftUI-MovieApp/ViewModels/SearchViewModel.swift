//
//  SearchViewModel.swift
//  SwiftUI-MovieApp
//
//  Created by Eduardo Macetas on 5/29/25.
//

import Foundation
import Combine

class SearchViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var searchQuery: String = ""

    private let apiService = MovieAPIService()
    private var cancellables = Set<AnyCancellable>()

    init() {
        setupSearch()
    }

    func searchMovies(query: String) {
        guard !query.isEmpty else {
            movies = []
            errorMessage = nil
            isLoading = false
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
