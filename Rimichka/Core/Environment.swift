//
//  AppEnvironment.swift
//  Rimichka
//
//  Created by Alexander Ignatov on 24.07.20.
//  Copyright © 2020 Yalishanda. All rights reserved.
//

import Combine

// MARK: - Environment

struct AppEnvironment {
    let apiService: APIService
    let dbService: DatabaseService
}

// MARK: - API Service

protocol APIService {
    func rhymesForWord(_ word: String) -> AnyPublisher<[RhymePair], APIError>
}

enum APIError: Error {
    case unknown
    case domainChanged
    case noConnection
    case serizalizationFailed
}

// MARK: - Database Service

protocol DatabaseService {
    func fetchAllSaved() -> Set<RhymePair>
    func add(_ model: RhymePair)
    func remove(_ model: RhymePair)
}
