//
//  ObserverForDiary.swift
//  MovieDiary
//
//  Created by Ivan on 05.09.2026.
//

import Foundation

class ObserverForDiary: Observer {
    
    weak var responder: ObserverForDiaryProtocol?
    
    private var isObserving = false
    
    
    deinit {
        stopObserving()
    }
    
    func startObserving() {
        guard !isObserving else { return }
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleDiaryUpdate), name: .diaryDidUpdate, object: nil)
        
        isObserving = true
    }
    
    func stopObserving() {
        guard isObserving else { return }
        NotificationCenter.default.removeObserver(self, name: .diaryDidUpdate, object: nil)
        isObserving = false
    }
    
    
    
    @objc private func handleDiaryUpdate() {
        
        responder?.receivedDiaryUpdate()
    }
}
