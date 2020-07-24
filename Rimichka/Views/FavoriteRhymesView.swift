//
//  FavoriteRhymesView.swift
//  Rimichka
//
//  Created by Alexander Ignatov on 22.07.20.
//  Copyright © 2020 Yalishanda. All rights reserved.
//

import SwiftUI

struct FavoriteRhymesView: View {
    
    let favoriteRhymes: [RhymePair]
        
    var body: some View {
        favoriteRhymes.isEmpty
            ? AnyView(Text("Все още няма любими римички.").foregroundColor(Color.Asset.foreground))
            : AnyView(RhymesListView(rhymesList: favoriteRhymes.sorted { $0.text < $1.text } ))
    }
}

struct FavoriteRhymesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteRhymesView(favoriteRhymes: [])
        FavoriteRhymesView(favoriteRhymes: Array(repeating: .init(word: "Test", strength: 2, parentWord: "Example"), count: 10))
    }
}
