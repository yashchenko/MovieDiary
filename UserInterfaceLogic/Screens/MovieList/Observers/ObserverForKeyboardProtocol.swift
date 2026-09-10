//
//  ObserverForKeyboardProtocol.swift
//  MovieDiary
//
//  Created by Ivan on 09.09.2026.
//

import UIKit

protocol ObserverForKeyboardProtocol: AnyObject {
    
    func keyboardWillHide()
    
    func keyboardWillAppear(height: CGFloat)
}
