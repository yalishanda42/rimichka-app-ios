//
//  RimichkaApp.swift
//  Rimichka
//
//  Created by Alexander Ignatov on 22.07.20.
//  Copyright © 2020 Yalishanda. All rights reserved.
//

import SwiftUI

@main
struct RimichkaApp: App {
    
    private let store = AppStore(
        initialState: .init(),
        reducer: AppReducer.reduce,
        environment: .init(
            apiService: RimichkaAPIService(),
            dbService: RealmService()
        )
    )
    
    var body: some Scene {
        WindowGroup {
            RootView().environmentObject(store)
        }
    }
    
    init() {
        store.send(.loadPersistedFavorites)
    }    
}
