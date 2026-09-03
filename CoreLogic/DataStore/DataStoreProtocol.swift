//
//  DataStoreProtocol.swift
//  MovieDiary
//
//  Created by Ivan on 03.09.2026.
//

import Foundation

protocol DataStoreProtocol {
    
    func save(movie: MovieEntity)
    
    func fetchMovies() -> [MovieEntity]
    
    func isSaved(movieID: Int) -> Bool
}

extension Notification.Name {
    
    static let diaryDidUpdate = Notification.Name("diaryDidUpdate")
}
