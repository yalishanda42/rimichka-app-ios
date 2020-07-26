//
//  RimichkaAPIService.swift
//  Rimichka
//
//  Created by Alexander Ignatov on 23.07.20.
//  Copyright © 2020 Yalishanda. All rights reserved.
//

import Combine
import Foundation

class RimichkaAPIService {
    
    private lazy var decoder = JSONDecoder()
    
    func rhymesForWord(_ word: String) -> AnyPublisher<[FetchedRhyme], APIError> {
        guard let url = url(forWord: word) else {
            return Fail(error: .domainChanged).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: URLRequest(url: url))
            .mapError { _ -> APIError in .noConnection }
            .flatMap { [unowned self] pair -> AnyPublisher<[FetchedRhyme], APIError> in
                self.decode(pair.data)
            }.eraseToAnyPublisher()
    }
}

extension RimichkaAPIService {
    enum APIError: Error {
        case unknown
        case domainChanged
        case noConnection
        case serizalizationFailed
        
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
}

private extension RimichkaAPIService {
    func url(forWord word: String) -> URL? {
        return URL(string: "https://rimichka.com/?json=1&word=\(word.URLescaped)")
    }
    
    func decode<T: Decodable>(_ data: Data) -> AnyPublisher<T, APIError> {
        return Just(data)
            .decode(type: T.self, decoder: decoder)
            .mapError { _ in .serizalizationFailed }
            .eraseToAnyPublisher()
    }
}
