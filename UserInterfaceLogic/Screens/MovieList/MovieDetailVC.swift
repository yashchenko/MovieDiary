//
//  MovieDetailVC.swift
//  MovieDiary
//
//  Created by Ivan on 02.09.2026.
//

import UIKit

class MovieDetailVC: UIViewController, MovieDetailsIxResponder {
    
    private let customView: MovieDetailProtocol
    private let movie: MovieEntity
    private let useCase: SaveMovieUseCaseProtocol
    
    init(view: MovieDetailProtocol, movie: MovieEntity, useCase: SaveMovieUseCaseProtocol) {
        
        self.customView = view
        self.movie = movie
        self.useCase = useCase
        
        
        
        super.init(nibName: nil, bundle: nil)
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
        
        title = "Details"
        
        customView.render(movie: movie)
    }
    
    func didSaveButtonTapped() {
        useCase.save(movie: movie)
    }
}
