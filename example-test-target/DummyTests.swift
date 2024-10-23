
import XCTest
import Common
import CommonTestingSupport

@testable import App

final class DummyTests: XCTestCase {

  func testExample() throws {
    let sut = Bar(multiplier: MockMultiplier())

    XCTAssertEqual(62, sut.calculate())
  }
}
