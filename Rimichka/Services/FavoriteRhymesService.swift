//
//  FavoriteRhymesService.swift
//  Rimichka
//
//  Created by Alexander Ignatov on 23.07.20.
//  Copyright © 2020 Yalishanda. All rights reserved.
//

import Combine

class FavoriteRhymesService {
    let favoriteRhymes: AnyPublisher<[RhymePair], Never>
    private let favoriteRhymesSubject = CurrentValueSubject<[RhymePair], Never>([])
    
    init() {
        favoriteRhymes = favoriteRhymesSubject.eraseToAnyPublisher()
    }
    
    func contains(_ model: RhymePair) -> Bool {
        return favoriteRhymesSubject.value.contains(model)
    }
    
    func add(_ model: RhymePair) {
        var models = favoriteRhymesSubject.value
        if !models.contains(model) {
            models.append(model)
            favoriteRhymesSubject.send(models)
        }
    }
    
    func remove(_ model: RhymePair) {
        var models = favoriteRhymesSubject.value
        models.removeAll { $0 == model }
        favoriteRhymesSubject.send(models)
    }
}
