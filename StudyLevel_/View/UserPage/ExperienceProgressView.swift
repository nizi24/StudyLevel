//
//  ExperienceProgress.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/11/20.
//

import SwiftUI

struct ExperienceProgressView: View {
    @ObservedObject var viewModel: UserPageViewModel
    @State var screen: CGSize = UIScreen.main.bounds.size
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Text("Lv." + String(viewModel.experience?.level ?? 0))
                        .font(.title2)
                    Text("Current Level")
                        .font(.footnote)
                }
                Spacer()
                VStack {
                    Text(String(viewModel.experience?.totalExperience ?? 0))
                        .font(.title2)
                        .foregroundColor(Color(UIColor(hex: viewModel.levelColor())))
                    Text("Total EXP")
                        .font(.footnote)
                }
                
            }
            .foregroundColor(Color(UIColor(hex: viewModel.levelColor())))
            .frame(width: screen.width * 7 / 10)
            
            HStack {
                ProgressView(value: viewModel.progress() ?? 0, total: 100)
                    .scaleEffect(y: 3)
                Text(viewModel.progressNumeretor())
                    .foregroundColor(.secondary)
                    .font(.footnote)
            }
            .frame(width: screen.width * 9 / 10)
        }
    }
}

struct ExperienceProgressView_Previews: PreviewProvider {
    static var previews: some View {
        ExperienceProgressView(viewModel: UserPageViewModel(id: 1))
    }
}
