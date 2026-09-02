//
//  MovieIxResponder.swift
//  MovieDiary
//
//  Created by Ivan on 20.08.2026.
//

import Foundation

protocol MovieIxResponder: AnyObject {
    
    func screenDidReady()
    
    func didSelectMovie(movie: MovieEntity)
}
