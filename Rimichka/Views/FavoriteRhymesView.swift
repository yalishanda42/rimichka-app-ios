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
        result.rhymesViewModels = [
            .init(text: "Test -> Test 1", isMarked: true),
            .init(text: "Test -> Test 2", isMarked: true),
            .init(text: "Test -> Test 3", isMarked: true),
            .init(text: "Test -> Test 4", isMarked: true),
            .init(text: "Test -> Test 5", isMarked: true),
        ]
        return result
    }
    
    static var previews: some View {
        FavoriteRhymesView(viewModel: testViewModel)
    }
}
