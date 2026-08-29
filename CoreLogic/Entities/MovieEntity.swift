//
//  MovieEntity.swift
//  MovieDiary
//
//  Created by Ivan on 14.08.2026.
//

import Foundation

// MARK: - Welcome
struct MoviePageEntity: Codable {
    let page: Int
    let results: [MovieEntity]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct MovieEntity: Codable {
    let adult: Bool
    let backdropPath: String
    let genreIDS: [Int]
    let id: Int
    let title: String
    let originalLanguage: String
    let originalTitle, overview: String
    let popularity: Double
    let posterPath, releaseDate: String
    let softcore, video: Bool
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id, title
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case softcore, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
