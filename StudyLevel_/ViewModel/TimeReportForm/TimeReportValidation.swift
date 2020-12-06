//
//  TimeReportValidation.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/11/27.
//

import Foundation

struct TimeReportValidation {
    
    func isTagValid(tagName: String, tags: [String]) -> Result<Bool, TimeReportValidationError> {
        if tagName.isEmpty {
            return .failure(.tagIsEmpty)
        } else if tagName.count > 50 {
            return .failure(.tagIsTooLong)
        } else if tags.count > 10 {
            return .failure(.tagsTooMany)
        } else if !tags.filter({ $0 == tagName }).isEmpty {
            return .failure(.tagsAreUnique)
        } else {
            return .success(true)
        }
    }
    
    func isMemoValid(memo: String) -> Result<Bool, TimeReportValidationError> {
        if memo.count > 280 {
            return .failure(.memoIsTooLong)
        } else {
            return .success(true)
        }
    }
    
    enum TimeReportValidationError: Error {
        case tagIsEmpty
        case tagIsTooLong
        case tagsTooMany
        case tagsAreUnique
        case memoIsTooLong
    }
}
