//
//  AddNoteTest.swift
//  IpSuiDauNotesTests
//
//  Created by Ipman on 18/08/2023.
//

import XCTest
@testable import IpSuiDauNotes
final class AddNoteTest: XCTestCase {
    var viewModel: NotesViewModel!
    override func setUp() {
        super.setUp()
        viewModel = NotesViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testValidateFormSucess(){
        let expectation = XCTestExpectation(description: "check success")
        let result = viewModel.validateForm(title: "", content: "")
        XCTAssertFalse(result, "Validate form Success")
        expectation.fulfill()
        wait(for: [expectation], timeout: 5.0)
    }
}
