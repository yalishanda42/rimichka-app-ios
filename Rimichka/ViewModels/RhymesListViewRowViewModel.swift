//
//  RhymesListViewRowViewModel.swift
//  Rimichka
//
//  Created by Alexander Ignatov on 22.07.20.
//  Copyright © 2020 Yalishanda. All rights reserved.
//

import Combine

class RhymesListViewRowViewModel: ObservableObject {
    @Published var isMarked: Bool {
        didSet {
            if isMarked {
                favoritesService.add(model)
            } else {
                favoritesService.remove(model)
            }
        }
    }
    
    var text: String {
        return "\(model.parentWord) -> \(model.word)"
    }
    
    private let model: RhymePair
    private let favoritesService: FavoriteRhymesService
    
    private var disposeBag: Set<AnyCancellable> = []
    
    init(with model: ModelType, favoritesService: FavoriteRhymesService) {
        switch model {
        case .fetchedRhyme(let original, let rhyme):
            self.model = rhyme.asRhymePair(originalWord: original)
        case .rhymePair(let pair):
            self.model = pair
        }
        
        self.favoritesService = favoritesService
        self.isMarked = favoritesService.contains(self.model)
    }
}

extension RhymesListViewRowViewModel {
    enum ModelType {
        case fetchedRhyme(String, FetchedRhyme)
        case rhymePair(RhymePair)
    }
}

extension RhymesListViewRowViewModel: Identifiable {
    var id: String {
        text
    }
}

extension FetchedRhyme {
    func asRhymePair(originalWord: String) -> RhymePair {
        .init(word: wrd, strength: pri, parentWord: originalWord)
    }
}

private extension RhymesListViewRowViewModel {
    func declareSubscriptions() {
        favoritesService.favoriteRhymes.sink { [unowned self] models in
            isMarked = models.contains(model)
        }.store(in: &disposeBag)
    }
}
