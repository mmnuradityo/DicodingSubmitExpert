//
//  ProfileViewController.swift
//  DS_PengenalanIos
//
//  Created by Admin on 03/09/23.
//
import Cleanse
import DSCore

public struct DetailViewBuilder {
  
  public init() { }
  
  public func create(game: GameModel?) -> DetailViewController {
    let useCase = DetailInteractor(repository: getRepository())
    let presenter = DetailPresenter(detailUseCase: useCase, game: game)
    let detailViewController = DetailViewController(presenter: presenter)
    return detailViewController
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
