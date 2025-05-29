//
//  SwiftUI_MovieAppApp.swift
//  SwiftUI-MovieApp
//
//  Created by Eduardo Macetas on 5/28/25.
//

import SwiftUI

@main
struct SwiftUI_MovieAppApp: App {
    @StateObject private var favoritesManager = FavoritesManager()

    var body: some Scene {
        WindowGroup {
            TabView {
                MovieListView()
                    .tabItem {
                        Label("Movies", systemImage: "film")
                    }
                SearchView()
                    .tabItem {
                        Label("Search", systemImage: "magnifyingglass")
                    }
                FavoritesView()
                    .tabItem {
                        Label("Favorites", systemImage: "heart.fill")
                    }
            }
            .environmentObject(favoritesManager)
        }
    }
}
