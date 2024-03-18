//
//  ProfileViewController.swift
//  DS_PengenalanIos
//
//  Created by Admin on 03/09/23.
//

import DSCore
import Cleanse

public struct ProfileBuilder {
  
  public init() { }
  
  public func create() -> ProfileViewController {
    let useCase = ProfileInteractor(repository: getRepository())
    let profilePresenter = ProfilePresenter(profileUserCae: useCase)
    let profileViewController = ProfileViewController(presenter: profilePresenter)
    return profileViewController
  }
  
  public func getRepository() -> GameRepositoryProtocol {
    do {
      let compoment = try ComponentFactory.of(RepositoryInjectionComponent.self)
      let inject = compoment.build(())
      return inject.getRepository()
    } catch {
      fatalError("Repository is nil!")
    }
  }
  
}
