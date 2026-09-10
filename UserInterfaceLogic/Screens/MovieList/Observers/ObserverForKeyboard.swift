
import UIKit

class ObserverForKeyboard: Observer {
    
    weak var responder: ObserverForKeyboardProtocol?
    
    var observer = false
    
    deinit {
        stopObserving()
    }
    
    func startObserving() {
        if !observer {
            let nc = NotificationCenter.default
            nc.addObserver(self, selector: #selector(handleShowKeyboard(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
            nc.addObserver(self, selector: #selector(handleHideKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
            observer = true
        }
    }
    
    func stopObserving() {
        if observer {
            let nc = NotificationCenter.default
            nc.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
            nc.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
            observer = false
        }
    }
    
    @objc func handleShowKeyboard(_ notification: Notification) {
        
        guard let userInfo = notification.userInfo, let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            
            return
        }
        
        let height = keyboardFrame.cgRectValue.height
        responder?.keyboardWillAppear(height: height)
    }
    
    @objc func handleHideKeyboard() {
        
        responder?.keyboardWillHide()
    }
}
