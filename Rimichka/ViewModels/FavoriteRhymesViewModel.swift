//
//  FavoriteRhymesViewModel.swift
//  Rimichka
//
//  Created by Alexander Ignatov on 22.07.20.
//  Copyright © 2020 Yalishanda. All rights reserved.
//

import Combine

class FavoriteRhymesViewModel: ObservableObject {
    @Published var rhymesViewModels: [RhymesListViewRowViewModel] = []
}
