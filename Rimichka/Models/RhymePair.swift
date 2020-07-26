//
//  RhymePairswift
//  Rimichka
//
//  Created by Aleksandar Ignatov on 4.07.19.
//  Copyright © 2019 Yalishanda. All rights reserved.
//

import Foundation

/// Binds a (parent) word that rhymes with another word.
/// The parent word describes a word that the user types in order to search for rhymes.
struct RhymePair: Codable, Equatable, Hashable {
    let word: String
    let strength: Int
    var parentWord: String
}
