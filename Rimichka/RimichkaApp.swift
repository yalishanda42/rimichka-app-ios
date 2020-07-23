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
    
    private static let apiService = RimichkaAPIService()
    private static let favoritesService = FavoriteRhymesService()
    
    private static let rootViewModel = RootViewModel(
        apiService: apiService,
        favoritesService: favoritesService
    )
    
    var body: some Scene {
        WindowGroup {
            RootView(viewModel: RimichkaApp.rootViewModel)
        }
    }
}
