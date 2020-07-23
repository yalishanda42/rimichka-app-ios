//
//  RealmRhymePair.swift
//  Rimichka
//
//  Created by Alexander Ignatov on 23.07.20.
//  Copyright © 2020 Yalishanda. All rights reserved.
//

import Foundation
import RealmSwift

class RealmRhymePair: Object {
    @objc dynamic var word: String = ""
    @objc dynamic var strength: Int = 0
    @objc dynamic var parentWord: String = ""
}
