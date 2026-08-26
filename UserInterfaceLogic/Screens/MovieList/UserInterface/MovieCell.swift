//
//  MovieCell.swift
//  MovieDiary
//
//  Created by Ivan on 24.08.2026.
//

import UIKit

class MovieCell: UICollectionViewCell {
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        
        contentView.backgroundColor = .systemGray
        contentView.layer.cornerRadius = 8
        
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
        
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        
        ])
        
    }
    
    func configure(with: MovieEntity) {
        
        titleLabel.text = with.title
    }
}
