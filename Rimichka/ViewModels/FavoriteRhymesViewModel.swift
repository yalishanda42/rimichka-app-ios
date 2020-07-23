//
//  FavoriteRhymesViewModel.swift
//  Rimichka
//
//  Created by Alexander Ignatov on 22.07.20.
//  Copyright © 2020 Yalishanda. All rights reserved.
//

import Combine

class FavoriteRhymesViewModel: ObservableObject {
    @Published var rhymeViewModels: [RhymesListViewRowViewModel] = [] {
        didSet {
            listViewModel.rhymeViewModels = rhymeViewModels
        }
    }
    
    let listViewModel = RhymesListViewModel()
    
    private let favoritesService: FavoriteRhymesService

    private var disposeBag: Set<AnyCancellable> = []

    init(favoritesService: FavoriteRhymesService) {
        self.favoritesService = favoritesService
        
        favoritesService.favoriteRhymes.sink { [unowned self] models in
            rhymeViewModels = models.map { .init(with: .rhymePair($0), favoritesService: favoritesService) }
        }.store(in: &disposeBag)
    }
}
