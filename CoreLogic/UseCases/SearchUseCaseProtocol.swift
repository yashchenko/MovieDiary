//
//  SearchUseCaseProtocol.swift
//  MovieDiary
//
//  Created by Ivan on 09.09.2026.
//

import Foundation

protocol SearchUseCaseProtocol {
    func execute(query: String, completion: @escaping (Result<[MovieEntity], APIError>) -> Void)
}
