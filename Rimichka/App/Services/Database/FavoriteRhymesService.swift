//
//  FavoriteRhymesService.swift
//  Rimichka
//
//  Created by Alexander Ignatov on 23.07.20.
//  Copyright © 2020 Yalishanda. All rights reserved.
//

import Combine
import RealmSwift

class RealmService: DatabaseService {
    
    private let realm: Realm
    
    init() {
        do {
            self.realm = try Realm()
        } catch let error {
            fatalError("Realm failed to initialize: \(error.localizedDescription)")
        }
    }
    
    func add(_ model: RhymePair) {
        try? realm.write {
            realm.add(RealmRhymePair(from: model))
        }
    }
    
    func remove(_ model: RhymePair) {
        let realmModels = realm.objects(RealmRhymePair.self).filter { $0 == .init(from: model) }
        try? realm.write {
            realm.delete(realmModels)
        }
    }
    
    func fetchAllSaved() -> Set<RhymePair> {
        return Set(realm.objects(RealmRhymePair.self).map { $0.asDomainModel })
    }
}

extension RealmRhymePair {
    convenience init(from pair: RhymePair) {
        self.init()
        self.word = pair.word
        self.parentWord = pair.parentWord
    }
    
    var asDomainModel: RhymePair {
        .init(word: word, parentWord: parentWord)
    }
    
    static func == (lhs: RealmRhymePair, rhs: RealmRhymePair) -> Bool {
        return lhs.word == rhs.word && lhs.strength == rhs.strength && lhs.parentWord == rhs.parentWord
    }
}
