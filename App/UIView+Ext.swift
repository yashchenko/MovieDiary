//
//  UIView+Ext.swift
//  MovieDiary
//
//  Created by Ivan on 31.08.2026.
//

import UIKit

extension UIView {
    
    func addSubviews(view: [UIView]) {
        
        view.forEach { child in
            addSubview(child)
        }
    }
    
    func tamic(view: [UIView]) {
        
        view.forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
        }
    }
}
 
