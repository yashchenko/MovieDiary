//
//  FetchDiaryMoviesProtocol.swift
//  MovieDiary
//
//  Created by Ivan on 05.09.2026.
//

import Foundation

protocol FetchDiaryMoviesUseCaseProtocol {
    func execute() -> [MovieEntity]
}
