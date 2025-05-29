//
//  Movie.swift
//  SwiftUI-MovieApp
//
//  Created by Eduardo Macetas on 5/28/25.
//  Copyright © 2018 Eduardo Macetas. All rights reserved.
//

import Foundation

struct Movie: Codable, Identifiable, Equatable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    let voteAverage: Double
    let releaseDate: String?

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case releaseDate = "release_date"
    }
}
