//
//  GetTag.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/11/21.
//

import Foundation

class GetTag {
    
    func getTagsOfTimeReport(timeReportId: Int, success: @escaping ([Tag]) -> ()) {
        let request = TagsRequest().index(timeReportId: timeReportId)
        StudyLevelClient().send(request: request) { result in
            switch result {
            case .success(let tags):
                success(tags)
            case .failure(_): break
            }
        }
    }
}
