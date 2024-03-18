//
//  File.swift
//  
//
//  Created by Admin on 17/03/24.
//

import Combine

open class BaseInteractor<Repository> {
  
  public let repository: Repository
  
  public init(repository: Repository) {
    self.repository = repository
  }
  
}
