//
//  RootView.swift
//  Rimichka
//
//  Created by Alexander Ignatov on 22.07.20.
//  Copyright © 2020 Yalishanda. All rights reserved.
//

import SwiftUI

struct RootView: View {
    
    @StateObject var viewModel: RootViewModel
    
    var body: some View {
        TabView {
            SearchRhymesView(viewModel: viewModel.searchViewModel).tabItem {
                Image.Asset.searchMore
                Text("Римички")
            }
            FavoriteRhymesView(viewModel: viewModel.favoritesViewModel).tabItem {
                Image.Asset.searchHeart
                Text("Любимички")
            }
        }.accentColor(Color.Asset.foreground)
        .background(Color.Asset.background)
    }
}
