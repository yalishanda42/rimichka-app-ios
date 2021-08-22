//
//  RimichkaAPIService.swift
//  Rimichka
//
//  Created by Alexander Ignatov on 23.07.20.
//  Copyright © 2020 Yalishanda. All rights reserved.
//

import Combine
import Foundation

class RimichkaAPIService: APIService {
    
    private lazy var decoder = JSONDecoder()
    
    func rhymesForWord(_ word: String) -> AnyPublisher<[RhymePair], APIError> {
        guard let url = url(forWord: word) else {
            return Fail(error: .domainChanged).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: URLRequest(url: url))
            .mapError { _ -> APIError in .noConnection }
            .flatMap { [unowned self] pair -> AnyPublisher<[FetchedRhyme], APIError> in
                self.decode(pair.data)
            }
            .map { list in
                list.map { $0.asRhymePair(originalWord: word) }
            }
            .eraseToAnyPublisher()
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

extension FetchedRhyme {
    func asRhymePair(originalWord: String) -> RhymePair {
        .init(word: wrd, parentWord: originalWord)
    }
}
