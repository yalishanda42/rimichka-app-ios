//
//  RhymesListView.swift
//  Rimichka
//
//  Created by Alexander Ignatov on 22.07.20.
//  Copyright © 2020 Yalishanda. All rights reserved.
//

import SwiftUI

struct RhymesListView: View {
    
    @StateObject var viewModel: RhymesListViewModel
    
    var body: some View {
        List(viewModel.rhymeViewModels) { vm in
            RhymesListViewRow(viewModel: vm)
        }
    }
}

struct RhymesListView_Previews: PreviewProvider {
    
    static var testViewModel: RhymesListViewModel {
        let result = RhymesListViewModel()
        result.rhymeViewModels = Array(repeating: .init(with: .rhymePair(.init(word: "Test", strength: 10, parentWord: "Example")), favoritesService: FavoriteRhymesService()), count: 20)
        return result
    }
    
    static var previews: some View {
        RhymesListView(viewModel: testViewModel)
    }
}
