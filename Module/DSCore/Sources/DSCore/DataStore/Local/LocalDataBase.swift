//
//  LocalDataSource.swift
//  DsCoreIos
//
//  Created by Admin on 17/03/24.
//

import Foundation
import Combine
import RealmSwift

public protocol LocalDataBaseProtocol {
  func getAll() -> AnyPublisher<[GameEntity], Error>
  func get(id: Int) -> AnyPublisher<GameEntity?, Error>
  func create(_ game: GameEntity) -> AnyPublisher<GameEntity, Error>
  func creates(_ games: [GameEntity]) -> AnyPublisher<[GameEntity], Error>
  func update(_ game: GameEntity) -> AnyPublisher<GameEntity, Error>
  func getGameByName(name: String) -> AnyPublisher<[GameEntity], Error>
  func getGameFavoriteByName(name: String) -> AnyPublisher<[GameEntity], Error>
  func deleteAll() -> AnyPublisher<Void, Error>
  func delete(_ id: Int) -> AnyPublisher<Void, Error>
}

public class LocalDataBase: NSObject {
  
  private let realm: Realm?
  
  public init(realm: Realm?) {
    self.realm = realm
  }
  
}

extension LocalDataBase: LocalDataBaseProtocol {
  
  public func getAll() -> AnyPublisher<[GameEntity], Error> {
    return Future<[GameEntity], Error> { completion in
      if let realm = self.realm {
        let games: Results<GameEntity> = {
          realm.objects(GameEntity.self)
        }()
        completion(.success(games.toArray(ofType: GameEntity.self)))
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
  
  public func get(id: Int) -> AnyPublisher<GameEntity?, Error> {
    return Future<GameEntity?, Error> { completion in
      if let realm = self.realm {
        let game: GameEntity? = realm.object(
          ofType: GameEntity.self, forPrimaryKey: String(id)
        )
        completion(.success(game))
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
  
  public func create(_ game: GameEntity) -> AnyPublisher<GameEntity, Error> {
    return Future<GameEntity, Error> { completion in
      if let realm = self.realm {
        do {
          try realm.write {
            realm.add(game, update: .all)
            completion(.success(game))
          }
        } catch {
          completion(.failure(DatabaseError.invalidInstance))
        }
      } else{
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
  
  public func creates(_ games: [GameEntity]) -> AnyPublisher<[GameEntity], Error> {
    return Future<[GameEntity], Error> { completion in
      if let realm = self.realm {
        do {
          try realm.write {
            for game in games {
              realm.add(game, update: .all)
            }
            completion(.success(games))
          }
        } catch {
          completion(.failure(error))
        }
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
  
  public func update(_ game: GameEntity) -> AnyPublisher<GameEntity, Error> {
    return Future<GameEntity, Error> { completion in
      if let realm = self.realm {
        let gameResult: GameEntity? = realm.object(
          ofType: GameEntity.self, forPrimaryKey: game.id
        )
        
        if let gameToUpdate = gameResult {
          do {
            try realm.write {
              gameToUpdate.gameDescription = game.gameDescription
              gameToUpdate.genre = game.genre
              gameToUpdate.reviewsCount = game.reviewsCount
              gameToUpdate.isFavorite = game.isFavorite
            }
            completion(.success(game))
            
          } catch {
            completion(.failure(error))
          }
          
        } else {
          completion(.failure(DatabaseError.notFound))
        }
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
  
  public func getGameByName(name: String) -> AnyPublisher<[GameEntity], Error> {
    return Future<[GameEntity], Error> { completion in
      if let realm = self.realm {
        let games: Results<GameEntity> = {
          realm.objects(GameEntity.self)
            .filter("title contains '\(name)'")
        }()
        completion(.success(games.toArray(ofType: GameEntity.self)))
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
  
  public func getGameFavoriteByName(name: String) -> AnyPublisher<[GameEntity], Error> {
    return Future<[GameEntity], Error> { completion in
      if let realm = self.realm {
        let games: Results<GameEntity> = {
          realm.objects(GameEntity.self)
            .filter("title contains '\(name)' And isFavorite = true")
        }()
        completion(.success(games.toArray(ofType: GameEntity.self)))
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
  
  public func deleteAll() -> AnyPublisher<Void, Error> {
    return Future { completion in
      if let realm = self.realm {
        do {
          try realm.write {
            realm.deleteAll()
            completion(.success(()))
          }
        } catch {
          completion(.failure(error))
        }
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
  
  public func delete(_ id: Int) -> AnyPublisher<Void, Error> {
    return Future { completion in
      if let realm = self.realm {
        let game: GameEntity? = realm.object(
          ofType: GameEntity.self, forPrimaryKey: String(id)
        )
        guard let game = game else {
          completion(.failure(DatabaseError.notFound))
          return
        }
        do {
          try realm.write {
            realm.delete(game)
            completion(.success(()))
          }
        } catch {
          completion(.failure(error))
        }
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
  
}
