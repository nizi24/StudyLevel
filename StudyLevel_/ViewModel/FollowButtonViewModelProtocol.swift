//
//  FollowButtonProtocol.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/11.
//

import Foundation

protocol FollowButtonViewModelProtocol: ObservableObject {
    var i: Int { get set }
    func follow(targetId: Int) -> Void
    func unfollow(targetId: Int) -> Void
}
