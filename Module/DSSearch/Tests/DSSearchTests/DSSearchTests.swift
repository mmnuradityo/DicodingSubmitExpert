//
//  DSSearchTests.swift
//  
//
//  Created by Admin on 18/03/24.
//

import XCTest

@testable import DSSearch
final class DSSearchTests: XCTestCase {
  
  func testBuilder() throws {
    let search = SearchViewBarBuilder().create()
    XCTAssertNotNil(search)
  }
  
}
