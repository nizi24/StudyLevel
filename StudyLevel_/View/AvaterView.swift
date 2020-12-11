//
//  AvaterView.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/11/20.
//

import SwiftUI

struct AvaterView: View {
    @ObservedObject var container: ImageContainer
    var size: CGFloat = 150
    
    var body: some View {
        Image(uiImage: container.image)
            .resizable()
            .scaledToFill()
            .frame(width: size, height: size)
            .cornerRadius(size / 2)
            .overlay(
                RoundedRectangle(cornerRadius: size / 2).stroke(Color.black, lineWidth: 0)
            )
    }
}

struct AvaterView_Previews: PreviewProvider {
    static var previews: some View {
        AvaterView(container: ImageContainer(from: URL(string: "https://user-images.githubusercontent.com/62362974/89768263-57719580-db36-11ea-9a23-bc6b1a49d0f8.png")!, userId: 2))
    }
}
