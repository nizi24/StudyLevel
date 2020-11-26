//
//  KeyBoradObserver.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/11/26.
//

import Foundation
import SwiftUI

class KeyboardObserver: ObservableObject {
    @Published var isShowing = false
        
    func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func removeObserver() {
        NotificationCenter.default.removeObserver(self,name: UIResponder.keyboardWillShowNotification,object: nil)
        NotificationCenter.default.removeObserver(self,name: UIResponder.keyboardWillHideNotification,object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        isShowing = true
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        isShowing = false
    }
}
