//
//  FavoriteRhymesView.swift
//  Rimichka
//
//  Created by Alexander Ignatov on 22.07.20.
//  Copyright © 2020 Yalishanda. All rights reserved.
//

import SwiftUI

struct FavoriteRhymesView: View {
    
    @StateObject var viewModel: FavoriteRhymesViewModel
    
    var listViewModel: RhymesListViewModel {
        let result = RhymesListViewModel()
        result.rhymeViewModels = viewModel.rhymesViewModels
        return result
    }
    
    var body: some View {
        viewModel.rhymesViewModels.isEmpty
            ? AnyView(Text("Все още няма любими римички.").foregroundColor(Color.Asset.foreground))
            : AnyView(RhymesListView(viewModel: listViewModel))
    }
}

struct FavoriteRhymesView_Previews: PreviewProvider {
    
    static var testViewModel: FavoriteRhymesViewModel {
        let result = FavoriteRhymesViewModel()
        result.rhymesViewModels = Array(repeating: .init(with: .rhymePair(RhymePair(word: "Word", strength: 0, parentWord: "Parent"))), count: 20)
        return result
    }
    
    static var previews: some View {
        FavoriteRhymesView(viewModel: FavoriteRhymesViewModel())
        FavoriteRhymesView(viewModel: testViewModel)
    }
}
