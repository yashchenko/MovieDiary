//
//  FetchDiaryMoviesUseCase.swift
//  MovieDiary
//
//  Created by Ivan on 05.09.2026.
//

import Foundation

class FetchDiaryMoviesUseCase: FetchDiaryMoviesUseCaseProtocol {
    
    
    private let dataStore: DataStoreProtocol
    
    init(dataStore: DataStoreProtocol) {
        self.dataStore = dataStore
    }
    
    func execute() -> [MovieEntity]  {
        
        dataStore.fetchMovies()
        
    }
}
