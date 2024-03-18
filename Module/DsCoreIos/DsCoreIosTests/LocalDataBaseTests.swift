//
//  LocalDataBaseTests.swift
//  DsCoreIosTests
//
//  Created by Admin on 17/03/24.
//

import XCTest
import RealmSwift

@testable import DsCoreIos
final class LocalDataBaseTests: XCTestCase {
  
  var realm: Realm?
  
  override func setUpWithError() throws {
    Realm.Configuration.defaultConfiguration.inMemoryIdentifier = self.name
    realm = try Realm()
  }
  
  override func tearDownWithError() throws {
    
  }
  
  func creteEntity(_ id: Int) -> GameEntity {
    let entity = GameEntity()
    entity.id = String(id)
    entity.title = "sample taitle"
    return entity
  }
  
  func testCreate() throws {
    create(game: creteEntity(UUID().hashValue))
  }
  
  func create(game: GameEntity) {
    if let realm = self.realm {
      do {
        try realm.write {
          realm.add(game, update: .all)
        }
      } catch {
        XCTAssertThrowsError(error)
      }
    } else{
      XCTAssertThrowsError(DatabaseError.invalidInstance)
    }
  }
  
  func testCreates() throws {
    var games: [GameEntity] = []
    games.append(creteEntity(UUID().hashValue))
    games.append(creteEntity(UUID().hashValue))
    
    creates(games: games)
  }
  
  func creates(games: [GameEntity]) {
    if let realm = self.realm {
      do {
        try realm.write {
          for game in games {
            realm.add(game, update: .all)
          }
        }
      } catch {
        XCTAssertThrowsError(error)
      }
    } else {
      XCTAssertThrowsError(DatabaseError.invalidInstance)
    }
  }
  
  func testGetAll() throws {
    try testCreate()
    
    getAll { games in
      if games.isEmpty {
        XCTAssertThrowsError(NSError(domain: "get All result empty", code: 0))
      }
    }
  }
  
  func getAll(completion: @escaping ([GameEntity]) -> Void) {
    if let realm = self.realm {
      let games: Results<GameEntity> = {
        realm.objects(GameEntity.self)
      }()
      completion(games.toArray(ofType: GameEntity.self))
    } else {
      XCTAssertThrowsError(DatabaseError.invalidInstance)
    }
  }
  
  func testGetSingle() throws {
    let id = UUID().hashValue
    let game = creteEntity(id)
    create(game: game)
    
    get(id: id) { result in
      if let gameResult = result,
         gameResult.id == game.id {
        return
      }
      
      XCTAssertThrowsError(NSError(domain: "failed to get single data", code: 0))
    }
  }
  
  func get(id: Int, completion: @escaping (GameEntity?) -> Void) {
    if let realm = self.realm {
      let game: GameEntity? = realm.object(
        ofType: GameEntity.self, forPrimaryKey: String(id)
      )
      completion(game)
    } else {
      XCTAssertThrowsError(DatabaseError.invalidInstance)
    }
  }
  
  func testUpdate() throws {
    let id = UUID().hashValue
    let game = creteEntity(id)
    create(game: game)
    
    get(id: id) { result in
      if let gameResult = result, game.id == gameResult.id {
        let title = "same name title"
        
        self.update(game: gameResult, title: title) { updatedGame in
          if updatedGame.title != title {
            XCTAssertThrowsError(NSError(domain: "failed to update data", code: 0))
          }
        }
        
      } else {
        XCTAssertThrowsError(NSError(domain: "failed to get single data", code: 0))
      }
    }
  }
  
  func update(game: GameEntity, title: String, completion: @escaping (GameEntity) -> Void) {
    if let realm = self.realm {
      let gameResult: GameEntity? = realm.object(
        ofType: GameEntity.self, forPrimaryKey: game.id
      )
      
      if let gameToUpdate = gameResult {
        do {
          try realm.write {
            gameToUpdate.title = title
          }
          completion(game)
          
        } catch {
          XCTAssertThrowsError(error)
        }
        
      } else {
        XCTAssertThrowsError(DatabaseError.invalidInstance)
      }
    } else {
      XCTAssertThrowsError(DatabaseError.invalidInstance)
    }
  }
  
  func testDelete() throws {
    let id = UUID().hashValue
    let game = creteEntity(id)
    create(game: game)
    
    delete(id: id)
  }
  
  func delete(id: Int) {
    if let realm = self.realm {
      let game: GameEntity? = realm.object(
        ofType: GameEntity.self, forPrimaryKey: String(id)
      )
      guard let game = game else {
        XCTAssertThrowsError(DatabaseError.notFound)
        return
      }
      do {
        try realm.write {
          realm.delete(game)
        }
      } catch {
        XCTAssertThrowsError(error)
      }
    } else {
      XCTAssertThrowsError(DatabaseError.invalidInstance)
    }
  }
  
  func testDeleteAll() throws {
    var games: [GameEntity] = []
    games.append(creteEntity(UUID().hashValue))
    games.append(creteEntity(UUID().hashValue))
    creates(games: games)
    
    deleteAll()
  }
  
  func deleteAll() {
    if let realm = self.realm {
      do {
        try realm.write {
          realm.deleteAll()
        }
      } catch {
        XCTAssertThrowsError(error)
      }
    } else {
      XCTAssertThrowsError(DatabaseError.invalidInstance)
    }
  }
  
  func testGetGameByName() throws {
    var games: [GameEntity] = []
    games.append(creteEntity(UUID().hashValue))
    games.append(creteEntity(UUID().hashValue))
    
    let titleName = "name to search"
    let game = creteEntity(UUID().hashValue)
    game.title = titleName
    games.append(game)
    
    creates(games: games)
    
    getGameByName(name: titleName) { games in
      if !games.contains(game) {
        XCTAssertThrowsError(NSError(domain: "failed to get data by name", code: 0))
      }
    }
  }
  
  func getGameByName(name: String, completion: @escaping ([GameEntity]) -> Void) {
    if let realm = self.realm {
      let games: Results<GameEntity> = {
        realm.objects(GameEntity.self)
          .filter("title contains '\(name)'")
      }()
      completion(games.toArray(ofType: GameEntity.self))
    } else {
      XCTAssertThrowsError(DatabaseError.invalidInstance)
    }
  }
  
  func testGetGameFavoriteByName() throws {
    var games: [GameEntity] = []
    games.append(creteEntity(UUID().hashValue))
    games.append(creteEntity(UUID().hashValue))
    
    let titleName = "name to search"
    let game = creteEntity(UUID().hashValue)
    game.title = titleName
    game.isFavorite = true
    games.append(game)
    
    creates(games: games)
    
    getGameFavoriteByName(name: titleName) { games in
      if !games.contains(game) {
        XCTAssertThrowsError(NSError(domain: "failed to get data favorite", code: 0))
      }
    }
  }
  
  func getGameFavoriteByName(name: String, completion: @escaping ([GameEntity]) -> Void) {
    if let realm = self.realm {
      let games: Results<GameEntity> = {
        realm.objects(GameEntity.self)
          .filter("title contains '\(name)' And isFavorite = true")
      }()
      completion(games.toArray(ofType: GameEntity.self))
    } else {
      XCTAssertThrowsError(DatabaseError.invalidInstance)
    }
  }
}
