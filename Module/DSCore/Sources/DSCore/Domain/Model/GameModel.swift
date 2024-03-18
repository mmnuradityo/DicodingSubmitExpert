//
//  Game.swift
//  DS_ExpertIOS
//
//  Created by Admin on 20/01/24.
//

import Foundation

public class GameModel: Identifiable, Equatable {
  public static func == (lhs: GameModel, rhs: GameModel) -> Bool {
    return lhs.id == rhs.id
  }
  
  public let id: Int
  public let title: String
  public let rating: Double
  public let releaseDate: Date?
  public let posterPath: String
  public var description: String
  public var genre: String
  public var reviewsCount: Int
   
  public var image: Data?
  public var state: DownloadState = .new
  public var isFavorite = false
  
  public init(
    id: Int,
    title: String,
    rating: Double,
    releaseDate: Date?,
    posterPath: String,
    description: String = "",
    genre: String = "-",
    reviewsCount: Int = 0,
    isFavorite: Bool = false
  ) {
    self.id = id
    self.title = title
    self.rating = rating
    self.releaseDate = releaseDate
    self.posterPath = posterPath
    self.description = description
    self.genre = genre
    self.reviewsCount = reviewsCount
    self.isFavorite = isFavorite
  }
  
  public func set(
    description: String,
    genre: String,
    reviewsCount: Int
  ) {
    self.description = description
    self.genre = genre
    self.reviewsCount = reviewsCount
  }
  
  public func configre(
    image: Data?,
    state: DownloadState
  ) {
    self.image = image
    self.state = state
  }
}
