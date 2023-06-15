//
//  ProgramViewTests.swift
//  VMedia TVTests
//
//  Created by Sd Saikat Das on 15/06/23.
//

@testable
import VMedia_TV
import XCTest

/// To show the potential of unit test
/// How to test private fields
/// For the sake of time only implementing for this View
/// THough best practice is to cover more than `90%` for Each `PR` we raise
class ProgramViewTests: XCTestCase {
    private var view: ProgramView!
    private var model: ProgramView.Model!

    override func setUp() {
        super.setUp()
        view = .init()
        model = .mock
    }

    override func tearDown() {
        super.tearDown()
        view = nil
        model = nil
    }
}

// MARK: - Tests

extension ProgramViewTests {
    func testModel() {
        // When
        view.model = model

        // Then
        XCTAssertEqual(view.model, model)
    }

    func testUIElementsInitialisedProperly() {
        // When
        view.model = model

        // Then
        XCTAssertEqual(view.testHooks.title, ProgramView.Model.Text.programName)
        XCTAssertEqual(view.testHooks.subTitle, ProgramView.Model.Text.time)
    }
}
