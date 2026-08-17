//
//  FetchPopularMovies.swift
//  MovieDiary
//
//  Created by Ivan on 17.08.2026.
//

import Foundation

class FetchPopularMovies: FetchPopularMoviesProtocol {
    
    let tmdb: RemoteAPI
    
    init(tmdb: RemoteAPI) {
        self.tmdb = tmdb
    }
    
    func execute(page: Int, completion: @escaping (Result<[MovieEntity], APIError>) -> Void) {
        
        tmdb.fetchMovies(pages: page, completion: completion)
    }
}
