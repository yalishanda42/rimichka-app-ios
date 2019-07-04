//
//  FavoriteRhymes.swift
//  Rimichka
//
//  Created by Aleksandar Ignatov on 3.07.19.
//  Copyright © 2019 Yalishanda. All rights reserved.
//

import Foundation

protocol FavoriteRhymesObserver: class {
  func favoriteRhymesDidUpdate(_ newList: [RhymePair])
}

/// Shared model instance that fetches from the database and saves
/// the favorite rhymes in the app's memory
class FavoriteRhymes {
  static let shared = FavoriteRhymes()
  private lazy var database = DatabaseManager.shared

  private var observers: [FavoriteRhymesObserver] = []
  private(set) var list: [RhymePair] = [] {
    didSet {
      observers.forEach { $0.favoriteRhymesDidUpdate(list) }
    }
  }
  
  private init() {
    list = database.fetchFavoriteRhymes()
  }
  
  func addObserver(_ newObserver: FavoriteRhymesObserver) {
    observers.append(newObserver)
  }
  
  func removeObserver(_ oldObserver: FavoriteRhymesObserver) {
    observers.removeAll { $0 === oldObserver }
  }
  
  func contains(_ rhyme: RhymePair) -> Bool {
    return list.contains(rhyme)
  }
  
  func add(_ rhyme: RhymePair) {
    database.saveRhyme(rhyme)
    list.append(rhyme)
  }
  
  func remove(_ rhyme: RhymePair) {
    database.deleteRhyme(rhyme)
    list.removeAll { $0 == rhyme }
  }
}
