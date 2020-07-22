//
//  RhymesListViewRowViewModel.swift
//  Rimichka
//
//  Created by Alexander Ignatov on 22.07.20.
//  Copyright © 2020 Yalishanda. All rights reserved.
//

import Combine

class RhymesListViewRowViewModel: ObservableObject {
    @Published var isMarked: Bool
    
    var text: String {
        switch model {
        case .fetchedRhyme(let rhyme):
            return rhyme.wrd
        case .rhymePair(let pair):
            return "\(pair.parentWord) -> \(pair.word)"
        }
    }
    
    var modelMarkStateChange: AnyPublisher<(ModelType, Bool), Never> {
        $isMarked.map { (self.model, $0) }.eraseToAnyPublisher()
    }
    
    let model: ModelType
    
    init(with model: ModelType, isMarked: Bool = false) {
        self.model = model
        self.isMarked = isMarked
    }
}

extension RhymesListViewRowViewModel {
    enum ModelType {
        case fetchedRhyme(FetchedRhyme)
        case rhymePair(RhymePair)
    }
}

extension RhymesListViewRowViewModel: Identifiable {
    var id: String {
        text
    }
}
