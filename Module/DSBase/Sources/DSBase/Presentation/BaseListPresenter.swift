//
//  File.swift
//  
//
//  Created by Admin on 17/03/24.
//

import Combine

open class BaseListPresenter<Response, UseCase>: BasePresenter {
  
  public let useCase: UseCase
  
  @Published public var games: [Response] = []
  @Published public var errorMessage: String = ""
  @Published public var loadingState: Bool = false
  
  public init(useCase: UseCase) {
    self.useCase = useCase
  }
}
