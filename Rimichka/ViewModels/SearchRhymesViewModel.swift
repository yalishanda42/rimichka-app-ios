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
            if case .loaded(rhymesResult: let rhymes, searchQuery: let originalWord) = state {
                rhymesListViewModel.rhymeViewModels = rhymes.map {
                    RhymesListViewRowViewModel.init(with: .fetchedRhyme(originalWord, $0), favoritesService: favoritesService)
                }
            } else {
                rhymesListViewModel.rhymeViewModels = []
            }
        }
    }
    
    @Published var searchQuery: String = ""
    let searchRequested = PassthroughSubject<Void, Never>()
    
    private let favoritesService: FavoriteRhymesService
    
    init(favoritesService: FavoriteRhymesService) {
        self.favoritesService = favoritesService
    }
}

extension SearchRhymesViewModel {
    enum SearchState {
        case initial
        case loading
        case failed(errorMessage: String)
        case loaded(rhymesResult: [FetchedRhyme], searchQuery: String)
    }
}
