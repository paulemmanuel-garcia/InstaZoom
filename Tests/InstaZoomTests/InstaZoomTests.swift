import XCTest
@testable import InstaZoom

class InstaZoomTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(InstaZoom().text, "Hello, World!")
    }


    static var allTests : [(String, (InstaZoomTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}
