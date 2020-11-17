//
//  SignupViewModelTest.swift
//  StudyLevel_Tests
//
//  Created by Yuu Nishida on 2020/11/17.
//

import Foundation
import XCTest
@testable import StudyLevel_

class SignupViewModelTest: XCTestCase {
    var viewModel = SignupViewModel()
    
    func testCreateErrorMessagesWithValid() {
        viewModel.name = "foobar"
        viewModel.email = "foo@example.com"
        viewModel.password = "password"
        viewModel.confirmationPassword = "password"
        
        viewModel.createErrorMessages()
        XCTAssert(viewModel.errorMessages.isEmpty)
    }
    
    func testCreateErrorMessagesWithInvalid() {
        viewModel.name = ""
        viewModel.email = "foo,.@example.com!"
        viewModel.password = "short"
        viewModel.confirmationPassword = "password"
        
        viewModel.createErrorMessages()
        XCTAssertEqual(viewModel.errorMessages[0], "名前は必須項目です")
        XCTAssertEqual(viewModel.errorMessages[1], "無効なメールアドレスです")
        XCTAssertEqual(viewModel.errorMessages[2], "パスワードは6文字以上にしてください")
        XCTAssertEqual(viewModel.errorMessages[3], "パスワードと確認が一致しません")
    }
}
