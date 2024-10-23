import XCTest
import CommonTestingSupport

@testable import Common

final class CommonTests: XCTestCase {
  func testExample() throws {
    let sut = Foo(multiplier: MockMultiplier())

    XCTAssertEqual(16, sut.calculate())
  }
}
