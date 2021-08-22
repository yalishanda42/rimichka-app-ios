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
    let showParentWord: Bool
    
    var body: some View {
        List(rhymesList) { rhyme in
            RhymesListViewRow(
                rhyme: rhyme,
                showParentWord: showParentWord,
                isMarked: store.state.favoriteRhymes.contains(rhyme),
                onTapIcon: { isMarkedBefore in
                    store.send(isMarkedBefore
                                ? .unmarkRhyme(rhyme)
                                : .markRhyme(rhyme)
                    )
                }
            )
        }
    }
}

struct RhymesListView_Previews: PreviewProvider {
    static var previews: some View {
        RhymesListView(rhymesList: Array(repeating: .init(word: "Test", parentWord: "Example"), count: 10), showParentWord: true)
    }
}

extension RhymePair: Identifiable {
    var fullText: String {
        "\(parentWord) -> \(word)"
    }
    
    var id: String {
        fullText
    }
}
