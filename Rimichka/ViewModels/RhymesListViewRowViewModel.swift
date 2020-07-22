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
    let text: String
    
    init(text: String = "", isMarked: Bool = false) {
        self.text = text
        self.isMarked = isMarked
    }
}

extension RhymesListViewRowViewModel: Identifiable {
    var id: String {
        text
    }
}
