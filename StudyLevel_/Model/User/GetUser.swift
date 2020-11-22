//
//  GetUser.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/11/19.
//

import Foundation

class GetUser {
    var user: User?
    var avatarURL: URL?
    var followingCount: Int?
    var followerCount: Int?
    
    func getUser(id: Int) -> User? {
        let request = UserRequest().show(id: id)
        let semaphore = DispatchSemaphore(value: 0)
        StudyLevelClient().send(request: request) { result in
            switch result {
            case .success(let user):
                self.user = user
            case .failure(_): break
            }
            semaphore.signal()
        }
        semaphore.wait()
        return self.user
    }
    
    func getAvatarURL(id: Int) -> URL? {
        let request = AvatarRequest().avatarURL(userId: id)
        let semaphore = DispatchSemaphore(value: 0)
        StudyLevelClient().send(request: request) { result in
            switch result {
            case .success(let avatarURL):
                self.avatarURL = avatarURL
            case .failure(_): break
            }
            semaphore.signal()
        }
        semaphore.wait()
        return self.avatarURL
    }
    
    func getFollowingCount(id: Int) -> Int? {
        let request = FollowCountRequest().followingCount(id: id)
        let semaphore = DispatchSemaphore(value: 0)
        StudyLevelClient().send(request: request) { result in
            switch result {
            case .success(let followingCount):
                self.followingCount = followingCount
            case .failure(_): break
            }
            semaphore.signal()
        }
        semaphore.wait()
        return self.followingCount
    }
    
    func getFollowerCount(id: Int) -> Int? {
        let request = FollowCountRequest().followerCount(id: id)
        let semaphore = DispatchSemaphore(value: 0)
        StudyLevelClient().send(request: request) { result in
            switch result {
            case .success(let followerCount):
                self.followerCount = followerCount
            case .failure(_): break
            }
            semaphore.signal()
        }
        semaphore.wait()
        return self.followerCount
    }
}
