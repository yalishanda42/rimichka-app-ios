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
    
    var body: some View {
        viewModel.rhymeViewModels.isEmpty
            ? AnyView(Text("Все още няма любими римички.").foregroundColor(Color.Asset.foreground))
            : AnyView(RhymesListView(viewModel: viewModel.listViewModel))
    }
}

struct FavoriteRhymesView_Previews: PreviewProvider {
    
    static var testViewModel: FavoriteRhymesViewModel {
        let result = FavoriteRhymesViewModel(favoritesService: FavoriteRhymesService())
        result.rhymeViewModels = Array(repeating: .init(with: .rhymePair(RhymePair(word: "Word", strength: 0, parentWord: "Parent")), favoritesService: FavoriteRhymesService()), count: 20)
        return result
    }
    
    static var previews: some View {
        FavoriteRhymesView(viewModel: FavoriteRhymesViewModel(favoritesService: FavoriteRhymesService()))
        FavoriteRhymesView(viewModel: testViewModel)
    }
}
