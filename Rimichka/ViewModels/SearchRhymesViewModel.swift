//
//  SearchRhymesViewModel.swift
//  Rimichka
//
//  Created by Alexander Ignatov on 22.07.20.
//  Copyright © 2020 Yalishanda. All rights reserved.
//

import Combine

class SearchRhymesViewModel: ObservableObject {
    let rhymesListViewModel = RhymesListViewModel()
    @Published var state: SearchState = .initial {
        didSet {
            if case .loaded(rhymesResult: let rhymes) = state {
                rhymesListViewModel.rhymeViewModels = rhymes.map {
                    RhymesListViewRowViewModel.init(with: .fetchedRhyme($0))
                }
            } else {
                rhymesListViewModel.rhymeViewModels = []
            }
        }
    }
    
    @Published var searchQuery: String = ""
    let searchRequested = PassthroughSubject<Void, Never>()
}

extension SearchRhymesViewModel {
    enum SearchState {
        case initial
        case loading
        case failed(errorMessage: String)
        case loaded(rhymesResult: [FetchedRhyme])
    }
}
