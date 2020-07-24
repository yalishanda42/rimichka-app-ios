//
//  RhymesListView.swift
//  Rimichka
//
//  Created by Alexander Ignatov on 22.07.20.
//  Copyright © 2020 Yalishanda. All rights reserved.
//

import SwiftUI

struct RhymesListView: View {
    
    @EnvironmentObject var store: AppStore
    let rhymesList: [RhymePair]
    
    var body: some View {
        List(rhymesList) { rhyme in
            RhymesListViewRow(
                rhyme: rhyme,
                isMarked: store.state.favoriteRhymes.contains(rhyme)
            )
        }
    }
}

struct RhymesListView_Previews: PreviewProvider {
    static var previews: some View {
        RhymesListView(rhymesList: Array(repeating: .init(word: "Test", strength: 3, parentWord: "Example"), count: 10))
    }
}

extension RhymePair: Identifiable {
    var text: String {
        "\(parentWord) -> \(word)"
    }
    
    var id: String {
        text
    }
}
