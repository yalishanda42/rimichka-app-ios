//
//  RhymesListViewRow.swift
//  Rimichka
//
//  Created by Alexander Ignatov on 22.07.20.
//  Copyright © 2020 Yalishanda. All rights reserved.
//

import SwiftUI

struct RhymesListViewRow: View {
    
    @StateObject var viewModel: RhymesListViewRowViewModel

    var body: some View {
        HStack {
            Text(viewModel.text)
            Spacer()
            Button(action: {
                viewModel.isMarked.toggle()
            }, label: {
                viewModel.isMarked ? Image.Asset.filledHeart : Image.Asset.emptyHeart
            }).foregroundColor(Color.Asset.foreground)
        }.padding(.vertical, 8)
        .padding(.horizontal, 10)
    }
}

struct RhymesListViewRow_Previews: PreviewProvider {
    static var previews: some View {
        RhymesListViewRow(viewModel: RhymesListViewRowViewModel(text: "Test", isMarked: false))
    }
}
