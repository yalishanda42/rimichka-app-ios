//
//  DatabaseManager.swift
//  Rimichka
//
//  Created by Aleksandar Ignatov on 3.07.19.
//  Copyright © 2019 Yalishanda. All rights reserved.
//

import UIKit
import CoreData

class DatabaseManager {
  static let shared = DatabaseManager()
  private init() {}
  
  typealias RhymeType = RhymePair

  private var context: NSManagedObjectContext {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    return appDelegate.persistentContainer.viewContext
  }
  
  func fetchFavoriteRhymes() -> [RhymeType] {
    var result: [RhymeType] = []
    let request = NSFetchRequest<RhymeEntity>(entityName: "RhymeEntity")
    do {
      let requestResult = try context.fetch(request)
      for requestResultItem in requestResult as [NSManagedObject] {
        let word = requestResultItem.value(forKey: "word") as? String ?? ""
        let strength = requestResultItem.value(forKey: "strength") as? Int ?? 0
        let parentWord = requestResultItem.value(forKey: "parentWord") as? String ?? ""
        let rhyme = RhymeType(word: word, strength: strength, parentWord: parentWord)
        result.append(rhyme)
      }
    } catch let error as NSError {
      print("Fetch from database failed (\(error)).")
    }
    return result
  }
  
//  func saveFavoriteRyhmes(_ rhymesList: [RhymeType]) {
//    // TODO
//  }
  
  func saveRhyme(_ rhyme: RhymeType) {
    let entity = NSEntityDescription.entity(forEntityName: "RhymeEntity", in: context)!
    let rhymeObject = NSManagedObject(entity: entity, insertInto: context)
    rhymeObject.setValue(rhyme.word, forKey: "word")
    rhymeObject.setValue(rhyme.strength, forKey: "strength")
    rhymeObject.setValue(rhyme.parentWord, forKey: "parentWord")
    saveContext()
  }
  
  func deleteRhyme(_ rhyme: RhymeType) {
    let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "RhymeEntity")
    request.predicate = NSPredicate(format: "word = %@ AND strength = %d AND parentWord = %@", rhyme.word, rhyme.strength, rhyme.parentWord)
    request.fetchLimit = 1
    do {
      let result = try context.fetch(request)
      let rhymeToBeDeleted = result[0] as! NSManagedObject
      context.delete(rhymeToBeDeleted)
    } catch let error as NSError {
      print("Could not delete rhyme \(rhyme.word) (\(error)).")
    }
    saveContext()
  }
  
  private func saveContext() {
    do {
      try context.save()
    } catch let error as NSError {
      print("Could not save databse context (\(error)).")
    }
  }
}
