//
//  RhymesListViewRow.swift
//  Rimichka
//
//  Created by Alexander Ignatov on 22.07.20.
//  Copyright © 2020 Yalishanda. All rights reserved.
//

import SwiftUI

struct RhymesListViewRow: View {
    
    let rhyme: RhymePair
    let isMarked: Bool
    let onTapIcon: (_ isMarkedBefore: Bool) -> Void
    
    var body: some View {
        HStack {
            Text(rhyme.text)
            Spacer()
            Button(action: {
                onTapIcon(isMarked)
            }, label: {
                isMarked ? Image.Asset.filledHeart : Image.Asset.emptyHeart
            }).foregroundColor(Color.Asset.foreground)
        }.padding(.vertical, 8)
        .padding(.horizontal, 10)
    }
}
