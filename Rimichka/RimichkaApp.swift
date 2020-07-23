//
//  RimichkaApp.swift
//  Rimichka
//
//  Created by Alexander Ignatov on 22.07.20.
//  Copyright © 2020 Yalishanda. All rights reserved.
//

import SwiftUI
import OSLog

@main
struct RimichkaApp: App {
    
    static let logger = OSLog(subsystem: "bg.yalishanda.Rimichka", category: .pointsOfInterest)
    
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
