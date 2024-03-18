//
//  DataMaper.swift
//  DS_ExpertIOS
//
//  Created by Admin on 05/03/24.
//

import Foundation
import Pods_DsCoreIos

class GameMapper {
  
  static func modelToEntity(game: GameModel) -> GameEntity {
    let gameEntity = GameEntity()
    gameEntity.id = String(game.id)
    gameEntity.title = game.title
    gameEntity.rating = game.rating
    gameEntity.releaseDate = DateUtils.getDateStringFull(date: game.releaseDate)
    gameEntity.posterPath = game.posterPath
    gameEntity.gameDescription = game.description
    gameEntity.genre = game.genre
    gameEntity.reviewsCount = game.reviewsCount
    gameEntity.isFavorite = game.isFavorite
    return gameEntity
  }
  
  static func entitiesToModel(entity: [GameEntity]) -> [GameModel] {
    return entity.map { result in
      return entityToModel(entity: result)
    }
  }
  
  static func entityToModel(entity: GameEntity) -> GameModel {
    return GameModel(
      id: Int(entity.id) ?? 0,
      title: entity.title,
      rating: entity.rating,
      releaseDate: DateUtils.generateDate(dateString: entity.releaseDate),
      posterPath: entity.posterPath,
      description: entity.gameDescription,
      genre: entity.genre,
      reviewsCount: entity.reviewsCount,
      isFavorite: entity.isFavorite
    )
  }
  
  static func responseToEntity(response: GamesResponse) -> [GameEntity] {
    let toResult = response.results ?? []
    
    return toResult.map { result in
      let gameEntity = GameEntity()
      gameEntity.id = String(result.id ?? 0)
      gameEntity.title = result.name ?? "not_found"
      gameEntity.rating = result.rating ?? 0.0
      gameEntity.releaseDate = result.released ?? ""
      gameEntity.posterPath = result.backgroundImage ?? "not_found"
      return gameEntity
    }
  }
  
  static func detailResponseToEntity(response: GameDetailResponse) -> GameEntity {
    let gameEntity = GameEntity()
    gameEntity.id = String(response.id ?? 0)
    gameEntity.title = response.name ?? "not_found"
    gameEntity.rating = response.rating ?? 0.0
    gameEntity.releaseDate = response.released ?? ""
    gameEntity.posterPath = response.backgroundImage ?? "not_found"
    gameEntity.gameDescription = response.description ?? "not_found"
    gameEntity.genre = generateGenre(response.genres)
    gameEntity.reviewsCount = response.reviewsCount ?? 0
    return gameEntity
  }
  
  private static func generateGenre(_ genres: [GenreDetails]?) -> String {
    guard let genres = genres else { return "not found" }
    
    var result: String = ""
    for genre in genres where genre.name != nil {
      result += " \(genre.name!),"
    }
    
    result.remove(at: result.startIndex)
    result.remove(at: result.index(before: result.endIndex))
    return result
  }
}
