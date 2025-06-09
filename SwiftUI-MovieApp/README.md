# SwiftUI MovieApp

A modern iOS app built with SwiftUI and MVVM architecture that connects to [The Movie Database (TMDB)](https://www.themoviedb.org/) API. Browse popular movies, search by title, and manage your favorites—all with a clean, native experience.

---

## Features

- Browse popular movies from TMDB
- Search for movies by title in a dedicated tab
- View detailed information for each movie (poster, title, description, rating, release date)
- Mark/unmark movies as favorites and view them in a dedicated tab
- Pull-to-refresh support for popular movies
- Persistent favorites using UserDefaults
- Clean MVVM architecture
- Dark mode support

---

## Requirements

- Xcode 14 or later
- iOS 15.0 or later (Simulator or real device)
- Swift 5.7 or later
- A [TMDB API Key](https://www.themoviedb.org/settings/api)

---

## Getting Started

### 1. Clone the repository

```sh
git clone https://github.com/yourusername/SwiftUI-MovieApp.git
cd SwiftUI-MovieApp
```

### 2. Open the project in Xcode
Double-click the SwiftUI-MovieApp.xcodeproj file to open the project in Xcode.

### 3. Insert your TMDB API Key

- Go to SwiftUI-MovieApp/Services/MovieAPIService.swift
- Replace the value of apiKey with your TMDB API key:
  ```sh
  private let apiKey = "YOUR_TMDB_API_KEY"
  ```

### 4. Build and run
- Select a simulator or your device in Xcode.
- Press Cmd + R or click the Run button to build and launch the app.
