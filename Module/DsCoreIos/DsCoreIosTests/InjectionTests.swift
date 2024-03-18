//
//  InjectionTest.swift
//  DsCoreIosTests
//
//  Created by Admin on 17/03/24.
//

import XCTest
import Cleanse

@testable import DsCoreIos
final class InjectionTests: XCTestCase {
  
  func testSingletonObject() throws {
    let injector = getInjector()
    let anotherInjector = getInjector()
    
    let _=injector.getRepository()
    let _=anotherInjector.getRepository()
  }
  
  private func getInjector() -> RepositoryInjection {
    let compoment = try! ComponentFactory.of(RepositoryInjectionComponent.self)
    let inject = compoment.build(())
    return inject
  }
  
}
