//
//  TimeReportsViewProtocol.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/07.
//

import Foundation

protocol TimeReportsViewModelProtocol: ObservableObject {
    var timeReports: [TimeReport]? { get set }
    var connecting: Bool { get set }
    var error: Bool { get set }
    var errorMessage: String { get set }
    var message: String { get set }
    var subMessage: String { get set }
    
    func getTimeReports() -> Void
    func getTimeReportMore() -> Void
}
