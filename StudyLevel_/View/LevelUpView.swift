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
            ZStack {
                VStack {
                    HStack {
                        Text("Level UP!!")
                            .foregroundColor(Color(UIColor(hex: "FFD54F")))
                            .bold()
                            .padding(.leading)
                        LottieView(filename: "8804-level-up-confetti-animation")
                            .frame(width: 100, height: 100)
                    }
                    Text("Lv.\(level)")
                        .foregroundColor(Color(UIColor(hex: "FF6F00")))
                        .bold()
                        .padding(.bottom)
                }
                .font(.largeTitle)
                LottieView(filename: "34524-confetti")
                    .frame(width: 300, height: 150)
            }
        })
    }
}
