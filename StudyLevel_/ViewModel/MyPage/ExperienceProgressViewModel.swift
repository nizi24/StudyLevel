//
//  ExperienceProgressViewModel.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/11/20.
//

import Foundation

class ExperienceProgressViewModel: ObservableObject {
    @Published var level = 0
    @Published var totalExperience = 0
    @Published var experienceToNext = 0
}
