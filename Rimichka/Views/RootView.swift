//
//  RootView.swift
//  Rimichka
//
//  Created by Alexander Ignatov on 22.07.20.
//  Copyright © 2020 Yalishanda. All rights reserved.
//

import SwiftUI

struct RootView: View {
    
    @EnvironmentObject var store: AppStore
    
    var body: some View {
        TabView {
            SearchRhymesView(searchState: store.state.searchState).tabItem {
                Image.Asset.searchMore
                Text("Римички")
            }
            FavoriteRhymesView(favoriteRhymes: store.state.favoriteRhymes.asArray).tabItem {
                Image.Asset.searchHeart
                Text("Любимички")
            }
        }.accentColor(Color.Asset.foreground)
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
