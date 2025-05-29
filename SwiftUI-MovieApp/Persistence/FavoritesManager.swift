//
//  FavoritesManager.swift
//  SwiftUI-MovieApp
//
//  Created by Eduardo Macetas on 5/28/25.
//

import Foundation

class FavoritesManager: ObservableObject {
    @Published private(set) var favorites: [Movie] = []

    private let key = "favorite_movies"

    init() {
        loadFavorites()
    }

    func isFavorite(_ movie: Movie) -> Bool {
        favorites.contains(where: { $0.id == movie.id })
    }

    func add(_ movie: Movie) {
        if !isFavorite(movie) {
            favorites.append(movie)
            saveFavorites()
        }
    }

    func remove(_ movie: Movie) {
        favorites.removeAll { $0.id == movie.id }
        saveFavorites()
    }

    private func saveFavorites() {
        if let data = try? JSONEncoder().encode(favorites) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }

    private func loadFavorites() {
        if let data = UserDefaults.standard.data(forKey: key),
           let movies = try? JSONDecoder().decode([Movie].self, from: data) {
            favorites = movies
        }
    }
}
