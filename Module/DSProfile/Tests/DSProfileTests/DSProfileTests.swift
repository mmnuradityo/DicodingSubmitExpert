import XCTest

@testable import DSProfile
final class DSProfileTests: XCTestCase {
  
  func testRouter() throws {
    let profileController = ProfileRouter().makeEditProfileViewController()
    XCTAssertNotNil(profileController)
  }
  
  func testBuilder() throws {
    let profile = ProfileBuilder().create()
    XCTAssertNotNil(profile)
  }
  
}
