//
//  AleatItem.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/02.
//

import Foundation
import SwiftUI

struct AlertItem: Identifiable {
    var id = UUID()
    var aleat: Alert
    
    init(aleat: Alert) {
        self.aleat = aleat
    }
}
