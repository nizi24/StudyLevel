//
//  GetExperienceRecord.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/11/21.
//

import Foundation

class GetExperienceRecord {
    var experienceRecord: ExperienceRecord?
    
    func getExperienceRecord(timeReportId id: Int) -> ExperienceRecord? {
        let request = ExperienceRecordRequest().show(timeReportId: id)
        let semaphore = DispatchSemaphore(value: 0)
        StudyLevelClient().send(request: request) { result in
            switch result {
            case .success(let experienceRecord):
                self.experienceRecord = experienceRecord
            case .failure(_): break
            }
            semaphore.signal()
        }
        semaphore.wait()
        return self.experienceRecord
    }
}
