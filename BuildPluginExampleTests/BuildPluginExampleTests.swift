//
//  BuildPluginExampleTests.swift
//  BuildPluginExampleTests
//
//  Created by Alex Apriamashvili on 27/9/2024.
//

import XCTest
import Common
import CommonTestingSupport

@testable import BuildPluginExample

final class BuildPluginExampleTests: XCTestCase {

  func testExample() throws {
    let sut = Bar(multiplier: MockMultiplier())

    XCTAssertEqual(62, sut.calculate())
  }
}
