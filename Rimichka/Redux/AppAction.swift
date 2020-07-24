//
//  AppAction.swift
//  Rimichka
//
//  Created by Alexander Ignatov on 24.07.20.
//  Copyright © 2020 Yalishanda. All rights reserved.
//

enum AppAction {
    case search(String)
    case setSearchResults([RhymePair])
    case failSearch(errorMessage: String)
    case loadPersistedFavorites
    case markRhyme(RhymePair)
    case unmarkRhyme(RhymePair)
}
