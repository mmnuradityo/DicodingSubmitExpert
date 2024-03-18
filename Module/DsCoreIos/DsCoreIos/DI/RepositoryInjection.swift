//
//  Injection.swift
//  DsCoreIos
//
//  Created by Admin on 17/03/24.
//

import Foundation
import Cleanse

public class RepositoryInjection {
  
  private let repositoryInataller: Provider<GameRepositoryProtocol>
  
  public init(repositoryInataller: Provider<GameRepositoryProtocol>) {
    self.repositoryInataller = repositoryInataller
  }
  
  public func getRepository() -> GameRepositoryProtocol {
    return repositoryInataller.get()
  }
}
