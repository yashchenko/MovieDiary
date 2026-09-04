//
//  SaveMovieUseCase.swift
//  MovieDiary
//
//  Created by Ivan on 03.09.2026.
//

import Foundation

class SaveMovieUseCase: SaveMovieUseCaseProtocol {
    
    private  let storage: UserDefaultsDataStore
    
    init(storage: UserDefaultsDataStore) {
        self.storage = storage
    }
    
    
    func save(movie: MovieEntity) {
        storage.save(movie: movie)
    }
}
