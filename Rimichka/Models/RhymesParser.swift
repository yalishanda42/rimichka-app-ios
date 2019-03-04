//
//  RhymesParser.swift
//  Rimichka
//
//  Created by Alexander on 4.03.19.
//  Copyright © 2019 Yalishanda. All rights reserved.
//

import Foundation

class RhymesParser {
    static var shared = RhymesParser()
    private init() {}
    
    
    struct Rhymes : Decodable {
        enum RhymeCodingKeys : String, CodingKey {
            case wrd; case pri
        }
        
        var rhymes = [(word: String?, strength: Int?)]()
        
        init(from decoder: Decoder) throws {
            var nestedRhymesList = try decoder.unkeyedContainer()
            
            if let numberOfRhymes = nestedRhymesList.count {
                for _ in 1...numberOfRhymes {
                    let rhymeContainer = try nestedRhymesList.nestedContainer(keyedBy: RhymeCodingKeys.self)
                    
                    let rhyme = try? rhymeContainer.decode(String.self, forKey: .wrd)
                    let number = try? rhymeContainer.decode(Int.self, forKey: .pri)
                    
                    rhymes.append((word: rhyme, strength: number))
                }
            }
        }
    }
    
    
    static func getRhymesForWord(word: String, completion: @escaping (Rhymes?) -> ()) {
        guard let url = URL(string: "http://rimichka.com/?word=\(word)&json=1") else {
            print("invalid URL!")
            completion(nil)
            return
        }
        
        Networking.getData(from: url) { (data) in
            if let data = data {
                let rhymes = try? JSONDecoder().decode(Rhymes.self, from: data)
                completion(rhymes)
            } else {
                completion(nil)
            }
        }
    }
}
