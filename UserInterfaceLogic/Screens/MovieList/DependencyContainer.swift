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
        
        movieListVC.onSelectMovie = { [weak self] movie in
            
            guard let self = self else { return }
            
            let detailVC = self.makeDetailVC(movie: movie)
            movieListVC.navigationController?.pushViewController(detailVC, animated: true)
            
        }
        
        movieListVC.didOpenDiary = { [weak self] in
            
            guard let self = self else { return }
            
            movieListVC.navigationController?.pushViewController(self.makeDiaryVC(), animated: true)
        }
    
        return movieListVC
    }
    
    private func makeDetailVC(movie: MovieEntity) -> UIViewController {
        
        let dataStore = UserDefaultsDataStore()
        let useCase = SaveMovieUseCase(storage: dataStore)
        
        
        let detailsView = MovieDetailRootView()
        detailsView.cachingProtocol = ImageCaching.shared
        
        
        let detailsVC = MovieDetailVC(view: detailsView, movie: movie, useCase: useCase)
        
        detailsView.saveMovieResponder = detailsVC
        return detailsVC
    }
    
    func makeDiaryVC() -> UIViewController {
        
        let dataStore = UserDefaultsDataStore()
        let useCase = FetchDiaryMoviesUseCase(dataStore: dataStore)
        let view = MovieListRootView()
        let observer = ObserverForDiary()
        let vc = ListSavedMoviesVC(view: view, useCase: useCase, observer: observer)
        
        view.responderSoem = vc
        
        return vc
    }
}
