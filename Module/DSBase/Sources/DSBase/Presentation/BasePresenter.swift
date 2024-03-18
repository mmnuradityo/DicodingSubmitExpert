//
//  BasePresenter.swift
//  DS_ExpertIOS
//
//  Created by Admin on 04/03/24.
//

import Combine

open class BasePresenter: ObservableObject {
  
  public var cancellables: Set<AnyCancellable> = []
  
  public init() {
    
  }
}
