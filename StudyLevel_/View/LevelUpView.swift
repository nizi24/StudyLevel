//
//  LevelUpView.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/24.
//

import SwiftUI

struct LevelUpView<Content>: View where Content: View {
    @Binding var isShowing: Bool
    var level: Int
    var content: () -> Content
    
    var body: some View {
        ModalView(isShowing: $isShowing, underContent: { content() }, modalContent: {
            VStack {
                HStack {
                    Text("Level UP!!")
                        .foregroundColor(Color(UIColor(hex: "FFD54F")))
                        .bold()
                        .padding(.vertical, 20)
                        .padding(.horizontal, 40)
                    
                }
                Text("Lv.\(level)")
                    .foregroundColor(Color(UIColor(hex: "FF6F00")))
                    .bold()
                    .padding()
            }
            .font(.largeTitle)
        })
    }
}
