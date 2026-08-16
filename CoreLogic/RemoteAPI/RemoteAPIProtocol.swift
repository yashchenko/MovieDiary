//
//  RemoteAPIProtocol.swift
//  MovieDiary
//
//  Created by Ivan on 13.08.2026.
//

import Foundation

protocol RemoteAPI {
    
    func fetchMovies(pages: Int, completion: @escaping (Result<[MovieEntity], APIError>) -> Void)
}
