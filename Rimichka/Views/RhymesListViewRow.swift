//
//  RhymesListViewRow.swift
//  Rimichka
//
//  Created by Alexander Ignatov on 22.07.20.
//  Copyright © 2020 Yalishanda. All rights reserved.
//

import SwiftUI

struct RhymesListViewRow: View {
    
    @EnvironmentObject var store: AppStore
    let rhyme: RhymePair
    @State var isMarked: Bool
    
    var body: some View {
        HStack {
            Text(rhyme.text)
            Spacer()
            Button(action: toggle, label: {
                isMarked ? Image.Asset.filledHeart : Image.Asset.emptyHeart
            }).foregroundColor(Color.Asset.foreground)
        }.padding(.vertical, 8)
        .padding(.horizontal, 10)
    }
    
    private func toggle() {
        isMarked.toggle()
        store.send(isMarked
                    ? .markRhyme(rhyme)
                    : .unmarkRhyme(rhyme)
        )
    }
}
