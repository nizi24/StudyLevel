//
//  ProfileSettingView.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/13.
//

import SwiftUI

struct ProfileSettingView: View {
    @ObservedObject var viewModel = ProfileSettingViewModel()
    var name: String?
    var screenName: String?
    var profile: String?
    
    var body: some View {
        VStack {
            Picker(selection: $viewModel.settingType, label: Text("設定")) {
                ForEach(ProfileSettingViewModel.SettingType.allCases, id: \.self) { type in
                    Text(type.rawValue).tag(type)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            Spacer()
            if viewModel.settingType == .profile {
                ProfileFromView(viewModel: ProfileFormViewModel(name: name, screenName: screenName, profile: profile))
            } else if viewModel.settingType == .avatar {
                AvatarImageFormView()
            }
        }
    }
}

struct ProfileSettingView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSettingView()
    }
}
