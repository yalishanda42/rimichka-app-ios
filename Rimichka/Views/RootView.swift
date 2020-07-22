//
//  RootView.swift
//  Rimichka
//
//  Created by Alexander Ignatov on 22.07.20.
//  Copyright © 2020 Yalishanda. All rights reserved.
//

import SwiftUI

struct RootView: View {
    
    @StateObject var viewModel: RootViewModel
    
    var body: some View {
        TabView {
            SearchRymesView(viewModel: viewModel.searchViewModel).tabItem {
                Image.Asset.searchMore
                Text("Римички")
            }
            FavoriteRhymesView(viewModel: viewModel.favoritesViewModel).tabItem {
                Image.Asset.searchHeart
                Text("Любимички")
            }
        }.accentColor(Color.Asset.foreground)
        .background(Color.Asset.background)
    }
}

struct RootView_Previews: PreviewProvider {
    
    static var testViewModel: RootViewModel {
        let result = RootViewModel()
        result.searchViewModel.rhymesListViewModel.rhymeViewModels = [
            .init(text: "Test 1", isMarked: false),
            .init(text: "Test 2", isMarked: true),
            .init(text: "Test 3", isMarked: true),
            .init(text: "Test 4", isMarked: false),
            .init(text: "Test 5", isMarked: true),
        ]
        result.favoritesViewModel.rhymesViewModels = [
            .init(text: "Test -> Test 1", isMarked: true),
            .init(text: "Test -> Test 2", isMarked: true),
            .init(text: "Test -> Test 3", isMarked: true),
            .init(text: "Test -> Test 4", isMarked: true),
            .init(text: "Test -> Test 5", isMarked: true),
        ]
        return result
    }
    
    static var previews: some View {
        RootView(viewModel: testViewModel)
    }
}
