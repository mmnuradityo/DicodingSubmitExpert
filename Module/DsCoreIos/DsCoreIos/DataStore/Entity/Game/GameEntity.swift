//
//  GameEntity.swift
//  DS_ExpertIOS
//
//  Created by Admin on 05/03/24.
//

import Foundation
import RealmSwift

public class GameEntity: Object {
  
  @objc dynamic var id: String = ""
  @objc dynamic var title: String = ""
  @objc dynamic var rating: Double = 0.0
  @objc dynamic var releaseDate: String = ""
  @objc dynamic var posterPath: String = ""
  @objc dynamic var gameDescription: String = ""
  @objc dynamic var genre: String = ""
  @objc dynamic var reviewsCount: Int = 0
  @objc dynamic var isFavorite: Bool = false
  
  public override class func primaryKey() -> String? {
    return "id"
  }
}
