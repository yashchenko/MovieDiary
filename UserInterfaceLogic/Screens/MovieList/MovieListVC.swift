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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func screenDidReady() {
        print("view is ready")
    }
}
