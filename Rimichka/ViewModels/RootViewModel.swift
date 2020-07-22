//
//  RootViewModel.swift
//  Rimichka
//
//  Created by Alexander Ignatov on 22.07.20.
//  Copyright © 2020 Yalishanda. All rights reserved.
//

import Combine
import Foundation

class RootViewModel: ObservableObject {
    let searchViewModel = SearchRhymesViewModel()
    let favoritesViewModel = FavoriteRhymesViewModel()
    
    private let service: RimichkaService
    private var disposeBag: Set<AnyCancellable> = []
    
    init(service: RimichkaService) {
        self.service = service
        declareSubscriptions()
    }
}

private extension RootViewModel {
    func declareSubscriptions() {
        searchViewModel.searchRequested
            .flatMap { [unowned self] _ -> AnyPublisher<[FetchedRhyme], Never> in
                let query = self.searchViewModel.searchQuery
                self.searchViewModel.state = .loading
                return service.rhymesForWord(query)
                    .receive(on: DispatchQueue.main)
                    .catch { apiError -> Empty<[FetchedRhyme], Never> in
                        self.searchViewModel.state = .failed(errorMessage: apiError.message)
                        return Empty(completeImmediately: true)
                    }.eraseToAnyPublisher()
            }.sink { [unowned self] result in
                self.searchViewModel.state = .loaded(rhymesResult: result)
            }.store(in: &disposeBag)
    }
}

extension RimichkaService.APIError {
    var message: String {
        switch self {
        case .domainChanged:
            return "Възникна основен проблем в приложението. Моля свържете се с програмистите."
        case .noConnection:
            return "Май няма интернет."
        case .serizalizationFailed:
            return "Нещо не успях да донеса тези рими."
        case .unknown:
            return "Възникна грешка. Опитайте пак по-късно."
        }
    }
}
