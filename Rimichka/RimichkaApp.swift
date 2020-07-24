//
//  RimichkaApp.swift
//  Rimichka
//
//  Created by Alexander Ignatov on 22.07.20.
//  Copyright © 2020 Yalishanda. All rights reserved.
//

import SwiftUI
import Combine

typealias AppStore = Store<AppState, AppAction, AppEnvironment>

@main
struct RimichkaApp: App {
    
    private let store = AppStore(
        initialState: .init(),
        reducer: RimichkaApp.reduce,
        environment: .init()
    )
    
    var body: some Scene {
        WindowGroup {
            RootView().environmentObject(store)
        }
    }
    
    init() {
        store.send(.loadPersistedFavorites)
    }
    
    static func reduce(
        state: inout AppState,
        action: AppAction,
        environment: AppEnvironment
    ) -> AnyPublisher<AppAction, Never> {
        switch action {
        
        case .search(let query):
            state.searchState = .loading
            return environment.apiService
                .rhymesForWord(query)
                .map { list in
                    list.map { fetched in
                        fetched.asRhymePair(originalWord: query)
                    }
                }.map { .setSearchResults($0) }
                .catch({ error -> Just<AppAction> in
                    return Just(.failSearch(errorMessage: error.message))
                }).eraseToAnyPublisher()
            
        case .failSearch(errorMessage: let message):
            state.searchState = .failed(errorMessage: message)
            
        case .setSearchResults(let results):
            state.searchState = .loaded(serchResults: results)
            
        case .loadPersistedFavorites:
            state.favoriteRhymes = environment.dbService.fetchAllSaved()
            
        case .markRhyme(let pair):
            state.favoriteRhymes.insert(pair)
            environment.dbService.add(pair)
            
        case .unmarkRhyme(let pair):
            state.favoriteRhymes.remove(pair)
            environment.dbService.remove(pair)
        }
        
        return Empty().eraseToAnyPublisher()
    }
}
