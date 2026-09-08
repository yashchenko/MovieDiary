//
//  MovieListVC.swift
//  MovieDiary
//
//  Created by Ivan on 19.08.2026.
//

import UIKit

class MovieListVC: UIViewController, MovieIxResponder {
    
    private let viewSome: MovieListUserInterfaceProtocol
    private let useCase: FetchPopularMoviesProtocol
    var onSelectMovie: ((MovieEntity) -> ())?
    var didOpenDiary: (() -> Void)?
    
    
    
    override func loadView() {
        
        guard let view = viewSome as? UIView else {
            super.loadView()
            return
        }
        
        self.view = view
    }
    
    init(view: MovieListUserInterfaceProtocol, useCase: FetchPopularMoviesProtocol) {
        self.viewSome = view
        self.useCase = useCase
        
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Catalogue"
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    func didSelectMovie(movie: MovieEntity) {
        onSelectMovie?(movie)
    }
    
    @objc private func didTapBarButton() {
        
        self.didOpenDiary?()
        
    }
}
