//
//  SignupValidationTest.swift
//  StudyLevel_Tests
//
//  Created by Yuu Nishida on 2020/11/17.
//

import Foundation
import XCTest
@testable import StudyLevel_

class SignupValidationTest: XCTestCase {
    var signupValidation: SignupValidation!
    
    override func setUp() {
        super.setUp()
        signupValidation = SignupValidation(viewModel: SignupViewModel())
    }
    
    func testIsValidNameWithEmpty() {
        signupValidation.viewModel.name = ""
        XCTAssertEqual(signupValidation.isValidName(), .failure(.nameIsRequired))
    }
    
    
}
