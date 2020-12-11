//
//  LazyView.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/11.
//

import SwiftUI

struct LazyView<Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    var body: Content {
        build()
    }
}
