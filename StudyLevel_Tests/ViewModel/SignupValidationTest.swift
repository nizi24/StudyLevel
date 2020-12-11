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
    
    func testIsValidNameWithValid() {
        signupValidation.viewModel.name = "tester"
        XCTAssertEqual(signupValidation.isValidName(), .success(true))
    }
    
    func testIsValidNameWithEmpty() {
        signupValidation.viewModel.name = ""
        XCTAssertEqual(signupValidation.isValidName(), .failure(.nameIsRequired))
    }
    
    func testIsValidNameWithTooLong() {
        signupValidation.viewModel.name = "123456789012345678901"
        XCTAssertEqual(signupValidation.isValidName(), .failure(.nameIsTooLong))
    }
    
    func testIsValidEmailWithValid() {
        signupValidation.viewModel.email = "test@example.com"
        XCTAssertEqual(signupValidation.isValidEmail(), .success(true))
    }
    
    func testIsValidEmailWithEmpty() {
        signupValidation.viewModel.email = ""
        XCTAssertEqual(signupValidation.isValidEmail(), .failure(.emailIsRequired))
    }
    
    func testIsValidEmailWithInvalid() {
        signupValidation.viewModel.email = "a,b,c@for."
        XCTAssertEqual(signupValidation.isValidEmail(), .failure(.invalidEmail))
    }
    
    func testIsValidPasswordWithValid() {
        signupValidation.viewModel.password = "password"
        XCTAssertEqual(signupValidation.isValidPassword(), .success(true))
    }
    
    func testIsValidPasswordWithEmpty() {
        signupValidation.viewModel.password = ""
        XCTAssertEqual(signupValidation.isValidPassword(), .failure(.passwordIsRequired))
    }
    
    func testIsValidPasswordWithTooShort() {
        signupValidation.viewModel.password = "foo"
        XCTAssertEqual(signupValidation.isValidPassword(), .failure(.passwordIsTooShort))
    }
    
    func testIsValidConfirmationPasswordWithValid() {
        signupValidation.viewModel.password = "password"
        signupValidation.viewModel.confirmationPassword = "password"
        XCTAssertEqual(signupValidation.isValidConfirmationPassword(), .success(true))
    }
    
    func testisValidConfirmationPasswordWithEmpty() {
        signupValidation.viewModel.confirmationPassword = ""
        XCTAssertEqual(signupValidation.isValidConfirmationPassword(), .failure(.confirmationPasswordIsRequired))
    }
    
    func testisValidConfirmationPasswordWithPasswordDoNotMatch() {
        signupValidation.viewModel.password = "password"
        signupValidation.viewModel.confirmationPassword = "foobar"
        XCTAssertEqual(signupValidation.isValidConfirmationPassword(), .failure(.confirmationAndPasswordDoNotMatch))
    }
}
