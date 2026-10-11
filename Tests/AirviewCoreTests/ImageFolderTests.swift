import XCTest
@testable import AirviewCore

final class ImageFolderTests: XCTestCase {
    func testIsImage() {
        XCTAssertTrue(ImageFolder.isImage(URL(fileURLWithPath: "/a.jpg")))
        XCTAssertTrue(ImageFolder.isImage(URL(fileURLWithPath: "/a.HEIC")))
        XCTAssertFalse(ImageFolder.isImage(URL(fileURLWithPath: "/a.txt")))
    }
}
