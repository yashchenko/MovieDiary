//
//  ListSavedMoviesVC.swift
//  MovieDiary
//
//  Created by Ivan on 07.09.2026.
//

import UIKit

class ListSavedMoviesVC: UIViewController, MovieIxResponder, ObserverForDiaryProtocol {
    
    private let customView: MovieListUserInterfaceProtocol
    private let fetchUseCase: FetchDiaryMoviesUseCaseProtocol
    private let observer: ObserverForDiary
    
    init(view: MovieListUserInterfaceProtocol, useCase: FetchDiaryMoviesUseCaseProtocol, observer: ObserverForDiary) {
        
        self.customView = view
        self.fetchUseCase = useCase
        self.observer = observer
        
        super.init(nibName: nil, bundle: nil)
        
        self.observer.responder = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        guard let view = customView as? UIView else {
            
            super.loadView()
            return
        }
        
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "My movies"
            
        observer.startObserving()
    }
    
    // MARK: - Movie ixResponder
    
    func screenDidReady() {
        loadMoviesFromDataBase()
    }
    
    func didSelectMovie(movie: MovieEntity) {
        // here will be next ticket
    }
    
    // db is chenged, refresh UI
    func receivedDiaryUpdate() {
        loadMoviesFromDataBase()
    }
    
    private func loadMoviesFromDataBase() {
        
        let savedMovies = fetchUseCase.execute()
        let state = MovieListViewState(isLoading: false, movies: savedMovies)
        customView.render(state: state)
    }
}
