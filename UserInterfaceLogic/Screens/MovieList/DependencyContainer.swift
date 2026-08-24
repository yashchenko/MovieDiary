//
//  DependencyContainer.swift
//  MovieDiary
//
//  Created by Ivan on 22.08.2026.
//

import UIKit

class DependencyContainer {
    
    weak var responder: MovieIxResponder?
    
    func assembly() -> UIViewController {
        
        let remoteApi = TMDBRemoteAPI()
        let useCase = FetchPopularMovies(tmdb: remoteApi)
        let movieListRootView = MovieListRootView()
        
        let movieListVC = MovieListVC(view: movieListRootView, useCase: useCase)
        movieListRootView.responderSoem = movieListVC
        
        return movieListVC
    }
    
}
