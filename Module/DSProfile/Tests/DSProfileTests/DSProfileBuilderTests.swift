import XCTest
import RealmSwift

@testable import DSProfile
final class DSProfileBuilderTests: XCTestCase {
  
  func testRouter() throws {
    let profileController = ProfileRouter().makeEditProfileViewController()
    XCTAssertNotNil(profileController)
  }
  
  func testBuilder() throws {
    let profile = ProfileBuilder().create()
    XCTAssertNotNil(profile)
  }
  
}
