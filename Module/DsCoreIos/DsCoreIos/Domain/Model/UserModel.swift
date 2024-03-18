//
//  UserModel.swift
//  DS_ExpertIOS
//
//  Created by Admin on 06/03/24.
//

import Foundation

public struct UserModel {
  public let firstName: String
  public let lastName: String
  public let avatar: Data?
  public let description: String
  public let address: String
  
  public init(
    firstName: String,
    lastName: String,
    avatar: Data?,
    description: String,
    address: String
  ) {
    self.firstName = firstName
    self.lastName = lastName
    self.avatar = avatar
    self.description = description
    self.address = address
  }
  
  public func fullName() -> String {
    return lastName.isEmpty ? firstName : "\(firstName) \(lastName)"
  }
}
