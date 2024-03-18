//
//  LocalDataBaseHelper.swift
//  DsCoreIos
//
//  Created by Admin on 17/03/24.
//

import Foundation
import RealmSwift

extension Results {
  func toArray<T>(ofType: T.Type) -> [T] {
    var array = [T]()
    for index in 0..<count {
      if let result = self[index] as? T {
        array.append(result)
      }
    }
    return array
  }
}

enum DatabaseError: LocalizedError {
  
  case invalidInstance
  case requestFailed
  case notFound
  
  var errorDescription: String? {
    switch self {
    case .invalidInstance: return "Database can't instance."
    case .requestFailed: return "Your request failed."
    case .notFound: return "Data not found!"
    }
  }
  
}
