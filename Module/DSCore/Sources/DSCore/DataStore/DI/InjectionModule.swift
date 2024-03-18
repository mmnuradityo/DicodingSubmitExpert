//
//  InjectionModule.swift
//  DS_ExpertIOS
//
//  Created by Admin on 15/03/24.
//

import Foundation
import Cleanse

public struct NetworkServiceModule: Module {
  public static func configure(binder: UnscopedBinder) {
    binder.bind(NetworkServiceProtocol.self)
      .to(factory: NetworkService.init)
  }
}

public struct ImageDownloaderModule: Module {
  public static func configure(binder: UnscopedBinder) {
    binder.bind(ImageDownloaderProtocol.self)
      .to(factory: ImageDownloader.init)
  }
}

public struct LocalDataBaseModule: Module {
  public static func configure(binder: UnscopedBinder) {
    binder.bind(LocalDataBaseProtocol.self)
      .to(factory: LocalDataBaseCreator.init().create)
  }
}

public struct ImageUtilsModule: Module {
  public static func configure(binder: UnscopedBinder) {
    binder.bind(ImageUtils.self)
      .to(factory: ImageUtilsImplementation.init)
  }
}
public struct UserEntityModule: Module {
  public static func configure(binder: UnscopedBinder) {
    binder.include(module: ImageUtilsModule.self)
    binder
      .bind(UserEntity.self)
      .to(factory: UserEntity.init)
  }
}

public struct GameRepositoryModule: Module {
  public static func configure(binder: Binder<Singleton>) {
    binder.include(module: NetworkServiceModule.self)
    binder.include(module: ImageDownloaderModule.self)
    binder.include(module: LocalDataBaseModule.self)
    binder.include(module: UserEntityModule.self)
    
    binder.bind(GameRepositoryProtocol.self)
      .sharedInScope()
      .to(factory: GameRepository.init)
  }
}

