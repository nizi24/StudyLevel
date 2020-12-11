//
//  MenuViewModel.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/11/19.
//

import Foundation
import FirebaseAuth

class MenuViewModel: ObservableObject {
    @Published var isNotLogin = false
    
    func logout() {
        do {
            try Auth.auth().signOut()
            isNotLogin = true
        } catch {
        }
    }
}
