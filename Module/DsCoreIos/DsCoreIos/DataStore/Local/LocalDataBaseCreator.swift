//
//  LocalDataBaseCreator.swift
//  DsCoreIos
//
//  Created by Admin on 17/03/24.
//

import Foundation
import RealmSwift

public class LocalDataBaseCreator {
  
  public init() {
    
  }
  
  public func create() -> LocalDataBaseProtocol {
    let realm = try? Realm()
    let LocalDB = LocalDataBase(realm: realm)
    return LocalDB
  }
  
}
