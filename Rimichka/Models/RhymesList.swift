//
//  RhymesList.swift
//  Rimichka
//
//  Created by Aleksandar Ignatov on 2.07.19.
//  Copyright © 2019 Yalishanda. All rights reserved.
//

import Foundation

/// Struct that decodes fetched JSON data from http://rimichka.com into a list of rhymes.
//struct RhymesList : Decodable {
//  var list: [Rhyme] = []
//
//  init(from decoder: Decoder) throws {
//    var nestedRhymesList = try decoder.unkeyedContainer()
//
//    if let numberOfRhymes = nestedRhymesList.count {
//      for _ in 1...numberOfRhymes {
//        let rhymeContainer = try nestedRhymesList.nestedContainer(keyedBy: RhymeCodingKeys.self)
//
//        let rhyme = try rhymeContainer.decode(String.self, forKey: .wrd)
//        let number = try rhymeContainer.decode(Int.self, forKey: .pri)
//
//        list.append(Rhyme(word: rhyme, strength: number, parentWord: nil))
//      }
//    }
//  }
//
//  subscript(_ index: Int) -> Rhyme {
//    return list[index]
//  }
//}

//extension RhymesList {
  /// Basic struct defining a rhyme model.
  struct RhymePair: Codable, Equatable {
    let word: String
    let strength: Int
    var parentWord: String?
  }
//}
//
//extension RhymesList {
//  enum RhymeCodingKeys : String, CodingKey {
//    case wrd // the word
//    case pri // the length of the rhymed end of the word
//  }
//}

struct FetchedRhyme: Codable {
  let word: String
  let strength : Int
}
