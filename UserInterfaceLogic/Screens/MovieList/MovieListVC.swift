//
//  MovieListVC.swift
//  MovieDiary
//
//  Created by Ivan on 19.08.2026.
//

import UIKit

class MovieListVC: UIViewController, MovieIxResponder, UISearchResultsUpdating, ObserverForKeyboardProtocol {
    
    
    private let viewSome: MovieListUserInterfaceProtocol
    private let useCase: FetchPopularMoviesProtocol
    var onSelectMovie: ((MovieEntity) -> ())?
    var didOpenDiary: (() -> Void)?
    private let searchUseCase: SearchUseCaseProtocol
    private let keyboardObserver: ObserverForKeyboard
    private var timer: Timer?
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    
    
    
    
    
    override func loadView() {
        
        guard let view = viewSome as? UIView else {
            super.loadView()
            return
        }
        
        self.view = view
    }
    
    init(view: MovieListUserInterfaceProtocol, useCase: FetchPopularMoviesProtocol, searchUseCase: SearchUseCaseProtocol, keyboardObserver: ObserverForKeyboard) {
        self.viewSome = view
        self.useCase = useCase
        self.searchUseCase = searchUseCase
        self.keyboardObserver = keyboardObserver
        
        
        super.init(nibName: nil, bundle: nil)
        
        self.keyboardObserver.responder = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Catalogue"
        setupButton()
        keyboardObserver.startObserving()
        setupSearchController()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSearchController() {
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Find movies..."
        
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
    }
    
    func setupButton() {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(didTapBarButton))
    }
    
    func screenDidReady() {
        print("view is ready")
        
        useCase.execute(page: 1) { [weak self] result in
            
            DispatchQueue.main.async {
                switch result {
                
                case .failure(let error):
                    print("MovieListVC: Error \(error)")
                    
                case .success(let movies):
                    print("🎬 Фильмы дошли до контроллера: \(movies.count) штук!")
                    let successState = MovieListViewState(isLoading: false, movies: movies)
                    
                    self?.viewSome.render(state: successState)
                    
                }
            }
        }
    }
    
    private func fetchSearch(query: String) {
        
        let loadingState = MovieListViewState(isLoading: true, movies: [])
        viewSome.render(state: loadingState)
        
        searchUseCase.execute(query: query) { [weak self] result in
            
            DispatchQueue.main.async {
                switch result {
                
                case .failure(let error):
                    print(error)
                    let errorState = MovieListViewState(isLoading: false, movies: [])
                    self?.viewSome.render(state: errorState)
                    
                case .success(let movies):
                    let succesState = MovieListViewState(isLoading: false, movies: movies)
                    self?.viewSome.render(state: succesState)
                }
            }
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text else { return }
        
        if query.isEmpty {
            timer?.invalidate()
            screenDidReady()
            return
        }
        
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { [weak self] _ in
            self?.fetchSearch(query: query)
        })
    }
    
    // MARK: - Keyboard Event Responder
    
    func keyboardWillHide() {
        viewSome.updateContentInser(bottom: 0)
    }
    
    func keyboardWillAppear(height: CGFloat) {
        viewSome.updateContentInser(bottom: height)
    }
    
    
    
    func didSelectMovie(movie: MovieEntity) {
        onSelectMovie?(movie)
    }
    
    @objc private func didTapBarButton() {
        
        self.didOpenDiary?()
        
    }
}
