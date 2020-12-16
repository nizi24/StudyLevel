//
//  ProfileSettingViewModel.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/13.
//

import Foundation

class ProfileSettingViewModel: ObservableObject {
    @Published var settingType: SettingType = .profile
    
    enum SettingType: String, CaseIterable {
        case profile = "プロフィール"
        case avatar = "アイコン画像"
    }
}
