//
//  LicensesView.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/27.
//

import SwiftUI

struct LicensesView: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack {
                    Text("・Level Up Animation by Chethan K V S")
                    Text("https://lottiefiles.com/8804-level-up-confetti-animation")
                        .font(.caption)
                        .padding(.top, 10)
                        .padding(.bottom)
                }
                Spacer()
            }
            Text("・Like Animation by Donghwa Kang")
            Text("https://lottiefiles.com/13450-like-animation")
                .font(.caption)
                .padding(.top, 10)
                .padding(.bottom)
            Text("・Book Loading Animation by thanhlocgp")
            Text("https://lottiefiles.com/28893-book-loading")
                .font(.caption)
                .padding(.top, 10)
                .padding(.bottom)
            Text("・Confetti Animation by Stephen Petrey")
            Text("https://lottiefiles.com/34524-confetti")
                .font(.caption)
                .padding(.top, 10)
                .padding(.bottom)
            Spacer()
        }
        .padding(.top)
        .padding(.leading)
    }
}

struct LicensesView_Previews: PreviewProvider {
    static var previews: some View {
        LicensesView()
    }
}
