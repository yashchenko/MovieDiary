//
//  FetchPopularMoviesProtoco;.swift
//  MovieDiary
//
//  Created by Ivan on 17.08.2026.
//

import Foundation

protocol FetchPopularMoviesProtocol {
    
    func execute(page: Int, completion: @escaping (Result<[MovieEntity], APIError>) -> Void)
    
}
