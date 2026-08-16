//
//  EnumError.swift
//  MovieDiary
//
//  Created by Ivan on 15.08.2026.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case networkError(Error)
    case invalidResponse
    case decodingError(Error)
}
