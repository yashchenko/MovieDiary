//
//  MovieListRootView.swift
//  MovieDiary
//
//  Created by Ivan on 19.08.2026.
//

import UIKit

class MovieListRootView: UIView, MovieListUserInterfaceProtocol {
    
    weak var responderSoem: MovieIxResponder?
    var movies: [MovieEntity] = []
    
    private let collectionView: UICollectionView
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    override func didMoveToWindow() {
        if self.window != nil {
            
            self.responderSoem?.screenDidReady()
        }
    }
    
    override init(frame: CGRect) {
        let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSize(width: 160, height: 240)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
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
        
        activityIndicator.hidesWhenStopped = true
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        backgroundColor = .systemBackground
        collectionView.backgroundColor = .systemBackground
        
        NSLayoutConstraint.activate([
            
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
            
        ])
        
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: "MovieCell")
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func render(state: MovieListViewState) {
        if state.isLoading {
            activityIndicator.startAnimating()

        } else {
            activityIndicator.stopAnimating()

        }
        
        collectionView.isHidden = state.isLoading
        
        movies = state.movies
        collectionView.reloadData()
    }
}

    
// MARK: - Extension

extension MovieListRootView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movies.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as? MovieCell
        let movie = movies[indexPath.row]
        cell?.cachingProtocol = ImageCaching.shared
        cell?.configure(with: movie)
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("indexPath: \(indexPath.row)")
        let movie = movies[indexPath.row]
        
        responderSoem?.didSelectMovie(movie: movie)
        
    }
}
