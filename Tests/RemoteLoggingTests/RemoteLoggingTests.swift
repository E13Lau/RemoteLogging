import XCTest
@testable import RemoteLogging

final class RemoteLoggingTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(RemoteLogging().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
