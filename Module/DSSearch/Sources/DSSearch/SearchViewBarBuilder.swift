//
//  File.swift
//  
//
//  Created by Admin on 17/03/24.
//

import Foundation
import DSCore
import Cleanse

public class SearchViewBarBuilder {
  
  public init() { }
  
  public func create() -> SearchViewBar {
    let useCase = SearchInteractor(repository: getRepository())
    let presenter = SearchPresenter(useCase: useCase)
    return SearchViewBar(presenter: presenter)
  }
  
  private func getRepository() -> GameRepositoryProtocol {
    do {
      let compoment = try ComponentFactory.of(RepositoryInjectionComponent.self)
      let inject = compoment.build(())
      return inject.getRepository()
    } catch {
      fatalError("Repository is nil!")
    }
  }
  
}
