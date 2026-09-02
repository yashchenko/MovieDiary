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
        
        
        
        
        
        return movieListVC
    }
    
    private func makeDetailVC(movie: MovieEntity) -> UIViewController {
        
        let detailsView = MovieDetailRootView()
        detailsView.cachingProtocol = ImageCaching.shared
        
        
        let detailsVC = MovieDetailVC(view: detailsView, movie: movie)
        return detailsVC
    }
    
}
