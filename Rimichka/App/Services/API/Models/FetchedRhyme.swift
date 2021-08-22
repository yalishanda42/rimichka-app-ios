//
//  FetchedRhyme.swift
//  Rimichka
//
//  Created by Aleksandar Ignatov on 4.07.19.
//  Copyright © 2019 Yalishanda. All rights reserved.
//

import Foundation

/// A single rhyme object as fetched from the http://rimichka.com REST API.
struct FetchedRhyme: Codable {
    let wrd: String // word
    let pri : Int  // strength
}
