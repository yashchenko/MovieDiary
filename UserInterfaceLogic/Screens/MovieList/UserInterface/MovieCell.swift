    //
    //  MovieCell.swift
    //  MovieDiary
    //
    //  Created by Ivan on 24.08.2026.
    //

    import UIKit

    class MovieCell: UICollectionViewCell {
        
        // MARK: - Properties
        
        weak var cachingProtocol: ImageCachingProtocol?
        
        var titleLabel: UILabel = {
            let label = UILabel()
            label.textAlignment = .center
            label.numberOfLines = 2
            label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
            label.textColor = .white
            label.backgroundColor = UIColor.black.withAlphaComponent(0.6)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        private var imageCell: UIImageView = {
            let image = UIImageView()
            image.contentMode = .scaleAspectFit
            image.clipsToBounds = true
            image.backgroundColor = .systemGray4
            image.layer.cornerRadius = 8
            image.translatesAutoresizingMaskIntoConstraints = false
            return image
        }()
        
        
        // MARK: - Init
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            setupUI()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        // MARK: - Setup
        
        override func prepareForReuse() {
            super.prepareForReuse()
            imageCell.image = nil
        }
        
        func setupUI() {
            
            contentView.backgroundColor = .systemGray
            contentView.layer.cornerRadius = 8
            
            contentView.addSubview(titleLabel)
            contentView.addSubview(imageCell)
            
            NSLayoutConstraint.activate([
                
                imageCell.topAnchor.constraint(equalTo: contentView.topAnchor),
                imageCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                imageCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                imageCell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                
                titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
                titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
                titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
                titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
                
            ])
            
        }
        
        func configure(with: MovieEntity) {
            
            titleLabel.text = with.title
            
            let posterPath = with.posterPath
            
            let url = "https://image.tmdb.org/t/p/w500" + posterPath
            
            self.cachingProtocol?.downloadImage(url: url, completion: { [weak self] result in
                
                DispatchQueue.main.async {
                    
                    
                    switch result {
                    
                    case .failure(let error):
                        print(error)
                        
                    case .success(let image):
                        
                        self?.imageCell.image = image
                    }
                    
            }
        })
    }
}
