//
//  MovieDiaryDependencyContainer.swift
//  MovieDiary
//
//  Created by Ivan on 11.08.2026.
//

import UIKit

class MovieDiaryDependencyContainer {
    
    init() {}
    
    func makeRootVC() -> UIViewController {
        
        let vc = TempVC()
        return vc
    }
}
