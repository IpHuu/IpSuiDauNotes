//
//  LoginTest.swift
//  IpSuiDauNotesTests
//
//  Created by Ipman on 18/08/2023.
//

import XCTest
@testable import IpSuiDauNotes
final class LoginTest: XCTestCase {
    var viewModel: LoginViewModel!
    override func setUp() {
        super.setUp()
        viewModel = LoginViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testCheckUserExsist(){
        viewModel.username = "ipman@gmail.com"
        let expectation = XCTestExpectation(description: "check success")
        viewModel.exsistUser { isExsist in
            XCTAssertTrue(isExsist, "Check completion")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testCheckUserNotExsist(){
        viewModel.username = "skdbksjbdkcskdj"
        let expectation = XCTestExpectation(description: "check success")
        viewModel.exsistUser { isExsist in
            XCTAssertFalse(isExsist, "Check completion")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testGetUserSuccess(){
        let expectation = XCTestExpectation(description: "get user success")
        viewModel.getUser(username: "ipman@gmail.com"){ user in
            XCTAssertNotNil(user, "Get User Success")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testGetUserFaild(){
        let expectation = XCTestExpectation(description: "get user success")
        viewModel.getUser(username: "asjkajnsdkja"){ user in
            XCTAssertNotNil(user, "Get User Failded")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }

}
