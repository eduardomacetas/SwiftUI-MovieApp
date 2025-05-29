//
//  MovieDetailviewModel.swift
//  SwiftUI-MovieApp
//
//  Created by Eduardo Macetas on 5/28/25.
//

import Foundation
import Combine

//class MovieListViewModel: ObservableObject {
class MovieDetailviewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var searchQuery: String = ""
    @Published var isLoading: Bool = false
    private var cancellables = Set<AnyCancellable>()
    
    private let movieAPIService = MovieAPIService()
    
    init() {
        fetchPopularMovies()
        
        $searchQuery
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] query in
                if query.isEmpty {
                    self?.fetchPopularMovies()
                } else {
                    self?.searchMovies(query: query)
                }
            }
            .store(in: &cancellables)
    }
    
    func fetchPopularMovies() {
        isLoading = true
        movieAPIService.fetchPopularMovies { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let movies):
                    self?.movies = movies
                case .failure(let error):
                    print("Error fetching popular movies: \(error)")
                }
            }
        }
    }
    
    func searchMovies(query: String) {
        isLoading = true
        movieAPIService.searchMovies(query: query) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let movies):
                    self?.movies = movies
                case .failure(let error):
                    print("Error searching movies: \(error)")
                }
            }
        }
    }
}
