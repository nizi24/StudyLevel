//
//  UserHTTPClient.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/11/19.
//

import Foundation

struct UserHTTPClient {
    
    
    func show(id: Int) {
        let request = UserRequest().show(id: id)
        StudyLevelClient().send(request: request) { result in
            switch result {
            case .success(let user): break
                
            case .failure(_): break
                <#code#>
            }
        }
    }
}
