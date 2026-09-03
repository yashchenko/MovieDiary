//
//  UserDefaultsDataStore.swift
//  MovieDiary
//
//  Created by Ivan on 03.09.2026.
//

import Foundation

class UserDefaultsDataStore: DataStoreProtocol {
    
    private let defaults = UserDefaults.standard
    
    private let storeKey = "diary_movies_key"
    
    
    func save(movie: MovieEntity) {
        var currentMovies = fetchMovies()
        
        if currentMovies.contains(where: { $0.id == movie.id }) {
            return
        }
        
        currentMovies.append(movie)
    }
    
    func fetchMovies() -> [MovieEntity] {
        guard let data = defaults.data(forKey: storeKey) else { return [] }
        
        do {
            let decoder = JSONDecoder()
            let movies = try decoder.decode([MovieEntity].self, from: data)
            return movies
            
        } catch {
            return []
        }
    }
    
    func isSaved(movieID: Int) -> Bool {
        let currentMovies = fetchMovies()
        return currentMovies.contains { ($0.id == movieID) }
        
    }
}
