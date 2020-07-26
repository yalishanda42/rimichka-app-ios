//
//  AppState.swift
//  Rimichka
//
//  Created by Alexander Ignatov on 24.07.20.
//  Copyright © 2020 Yalishanda. All rights reserved.
//

struct AppState {
    var searchState: SearchState = .initial
    var favoriteRhymes: Set<RhymePair> = []
}

extension AppState {
    enum SearchState {
        case initial
        case loading
        case failed(errorMessage: String)
        case loaded(serchResults: [RhymePair])
    }
}
