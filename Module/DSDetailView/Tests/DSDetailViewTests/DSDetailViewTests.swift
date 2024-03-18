//
//  DSDetailTests.swift
//  
//
//  Created by Admin on 18/03/24.
//

import XCTest
import RealmSwift

@testable import DSDetailView
final class DSDetailViewTests: XCTestCase {
  
  func testBuilder() throws {
    let detail = DetailViewBuilder().create(game: nil)
    XCTAssertNotNil(detail)
  }
  
}
