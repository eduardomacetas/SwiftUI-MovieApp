//
//  MovieAPIService.swift
//  SwiftUI-MovieApp
//
//  Created by Eduardo Macetas on 5/28/25.
//

import Foundation

class MovieAPIService {
//    private let apiKey = "YOUR_API_KEY" // Reemplaza esto con tu API Key real
    private let apiKey = "6c49e65076398ff0aeb2b935f7e947b9"
    private let baseURL = "https://api.themoviedb.org/3"

    func fetchPopularMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        let urlString = "\(baseURL)/movie/popular?api_key=\(apiKey)&language=en-US&page=1"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: 0, userInfo: nil)))
                return
            }

            do {
                let decoder = JSONDecoder()
                let movieResponse = try decoder.decode(MovieResponse.self, from: data)
                completion(.success(movieResponse.results))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    func searchMovies(query: String, completion: @escaping (Result<[Movie], Error>) -> Void) {
        // Asegúrate de codificar el query para URLs
        guard let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            completion(.failure(NSError(domain: "Invalid query", code: 0, userInfo: nil)))
            return
        }
        let urlString = "\(baseURL)/search/movie?api_key=\(apiKey)&language=en-US&query=\(encodedQuery)&page=1"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: 0, userInfo: nil)))
                return
            }

            do {
                let decoder = JSONDecoder()
                let movieResponse = try decoder.decode(MovieResponse.self, from: data)
                completion(.success(movieResponse.results))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

struct MovieResponse: Codable {
    let results: [Movie]
}
