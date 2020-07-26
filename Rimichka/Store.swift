//
//  AppStore.swift
//  Rimichka
//
//  Created by Alexander Ignatov on 24.07.20.
//  Copyright © 2020 Yalishanda. All rights reserved.
//

import Foundation
import Combine

final class Store<State, Action, Environment>: ObservableObject {
    typealias Reducer<State, Action, Environment> =
        (inout State, Action, Environment) -> AnyPublisher<Action, Never>
    
    @Published private(set) var state: State

    private let environment: Environment
    private let reducer: Reducer<State, Action, Environment>
    private var disposeBag: Set<AnyCancellable> = []

    init(
        initialState: State,
        reducer: @escaping Reducer<State, Action, Environment>,
        environment: Environment
    ) {
        self.state = initialState
        self.reducer = reducer
        self.environment = environment
    }

    func send(_ action: Action) {
        reducer(&state, action, environment)
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: send)
            .store(in: &disposeBag)
    }
}
