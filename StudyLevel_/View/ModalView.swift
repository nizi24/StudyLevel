//
//  ModalView.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/24.
//

import SwiftUI

struct ModalView<UnderContent, ModalContent>: View where UnderContent: View, ModalContent: View {
    @Binding var isShowing: Bool
    var underContent: () -> UnderContent
    var modalContent: () -> ModalContent
    
    var body: some View {
        ZStack {
            underContent()
                .blur(radius: isShowing ? 3 : 0)
                .animation(.easeIn)
            
            if isShowing {
                ZStack {
                    VStack {
                        modalContent()
                    }.compositingGroup()
                        .background(
                            RoundedRectangle(cornerRadius: 5)
                                .fill(Color(UIColor.systemBackground)))
                }.frame(minWidth: 0,
                       maxWidth: .infinity,
                       minHeight: 0,
                       maxHeight: .infinity)
                    .animation(.none)
                    .background(
                        Color.gray
                            .opacity(0.5))
                    .opacity(self.isShowing ? 1 : 0)
                    .animation(.easeIn)
                    .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    isShowing = false
                }
            }
        }
    }
}
