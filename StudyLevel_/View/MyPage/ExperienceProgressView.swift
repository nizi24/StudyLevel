//
//  ExperienceProgress.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/11/20.
//

import SwiftUI

struct ExperienceProgressView: View {
    @ObservedObject var viewModel: MyPageViewModel
    @State var screen: CGSize = UIScreen.main.bounds.size
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Text("Lv." + String(viewModel.experience?.level ?? 0))
                        .font(.title)
                    Text("Current Level")
                }
                Spacer()
                VStack {
                    Text(String(viewModel.experience?.totalExperience ?? 0))
                        .font(.title)
                        .foregroundColor(Color(UIColor(hex: viewModel.levelColor())))
                    Text("Total EXP")
                }
                
            }
            .foregroundColor(Color(UIColor(hex: viewModel.levelColor())))
            .frame(width: screen.width * 7 / 10)
            
            HStack {
                ProgressView(value: viewModel.progress() ?? 0, total: 100)
                    .scaleEffect(y: 5)
                Text(viewModel.progressNumeretor())
                    .foregroundColor(.secondary)
            }
            .frame(width: screen.width * 9 / 10)
        }
    }
}

struct ExperienceProgressView_Previews: PreviewProvider {
    static var previews: some View {
        ExperienceProgressView(viewModel: MyPageViewModel())
    }
}
