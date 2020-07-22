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
        result.rhymeViewModels = [
            .init(text: "Test 1", isMarked: false),
            .init(text: "Test 2", isMarked: true),
            .init(text: "Test 3", isMarked: true),
            .init(text: "Test 4", isMarked: false),
            .init(text: "Test 5", isMarked: true),
        ]
        return result
    }
    
    static var previews: some View {
        RhymesListView(viewModel: testViewModel)
    }
}
