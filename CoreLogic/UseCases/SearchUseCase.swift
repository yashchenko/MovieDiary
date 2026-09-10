//
//  SearchUseCase.swift
//  MovieDiary
//
//  Created by Ivan on 09.09.2026.
//

import Foundation

class SearchUseCase: SearchUseCaseProtocol {
    
    private let tmdb: TMDBRemoteAPI
    
    init(tmdb: TMDBRemoteAPI) {
        self.tmdb = tmdb
    }
    
    func execute(query: String, completion: @escaping (Result<[MovieEntity], APIError>) -> Void) {
    
        // no reason to make network request if search are empty
        guard !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            
            completion(.success([]))
            return
        }
        
        tmdb.searchMovies(query: query, completion: completion)
        
    }
}
