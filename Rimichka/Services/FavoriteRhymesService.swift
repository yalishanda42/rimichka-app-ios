//
//  FavoriteRhymesService.swift
//  Rimichka
//
//  Created by Alexander Ignatov on 23.07.20.
//  Copyright © 2020 Yalishanda. All rights reserved.
//

import Combine
import RealmSwift

class FavoriteRhymesService {
    let favoriteRhymes: AnyPublisher<[RhymePair], Never>
    private let favoriteRhymesSubject = CurrentValueSubject<[RhymePair], Never>([])
    
    private let realm: Realm
    
    init() {
        do {
            self.realm = try Realm()
        } catch let error {
            fatalError("Realm failed to initialize: \(error.localizedDescription)")
        }
        
        favoriteRhymes = favoriteRhymesSubject.eraseToAnyPublisher()
        
        loadAllFromDatabase()
    }
    
    func contains(_ model: RhymePair) -> Bool {
        return favoriteRhymesSubject.value.contains(model)
    }
    
    func add(_ model: RhymePair) {
        var models = favoriteRhymesSubject.value
        if !models.contains(model) {
            models.append(model)
            favoriteRhymesSubject.send(models)
            try? realm.write {
                realm.add(RealmRhymePair(from: model))
            }
        }
    }
    
    func remove(_ model: RhymePair) {
        var models = favoriteRhymesSubject.value
        models.removeAll { $0 == model }
        favoriteRhymesSubject.send(models)
        let realmModels = realm.objects(RealmRhymePair.self).filter { $0 == .init(from: model) }
        try? realm.write {
            realm.delete(realmModels)
        }
    }
    
    private func loadAllFromDatabase() {
        let saved = Array(realm.objects(RealmRhymePair.self).map { $0.asDomainModel })
        favoriteRhymesSubject.send(saved)
    }
}

extension RealmRhymePair {
    convenience init(from pair: RhymePair) {
        self.init()
        self.word = pair.word
        self.strength = pair.strength
        self.parentWord = pair.parentWord
    }
    
    var asDomainModel: RhymePair {
        .init(word: word, strength: strength, parentWord: parentWord)
    }
    
    static func == (lhs: RealmRhymePair, rhs: RealmRhymePair) -> Bool {
        return lhs.word == rhs.word && lhs.strength == rhs.strength && lhs.parentWord == rhs.parentWord
    }
}
