//
//  InjectionComponent.swift
//  DS_ExpertIOS
//
//  Created by Admin on 15/03/24.
//

import Foundation
import Cleanse

public struct RepositoryInjectionComponent: RootComponent {
  public typealias Root = RepositoryInjection
  
  public static func configure(binder: Binder<Singleton>) {
    binder.include(module: GameRepositoryModule.self)
  }
  
  public static func configureRoot(
    binder bind: ReceiptBinder<RepositoryInjection>
  ) -> BindingReceipt<RepositoryInjection> {
    return bind.to(factory: RepositoryInjection.init)
  }
}
