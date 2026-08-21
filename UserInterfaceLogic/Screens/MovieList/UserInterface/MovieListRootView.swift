//
//  MovieListRootView.swift
//  MovieDiary
//
//  Created by Ivan on 19.08.2026.
//

import UIKit

class MovieListRootView: UIView, MovieListUserInterfaceProtocol {
    
    weak var responderSoem: MovieIxResponder?
    
    private let collectionView: UICollectionView
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    override func didMoveToWindow() {
        if self.window != nil {
            
            self.responderSoem?.screenDidReady()
        }
    }
    
    override init(frame: CGRect) {
        let layout = UICollectionViewFlowLayout()
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        addSubview(activityIndicator)
        addSubview(collectionView)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
            
        ])
        
        
    }
    
    func render(state: MovieListViewState) {
        if state.isLoading {
            activityIndicator.startAnimating()
        } else {
            
            activityIndicator.stopAnimating()
        }
        
        collectionView.isHidden = state.isLoading
    }
}
    
