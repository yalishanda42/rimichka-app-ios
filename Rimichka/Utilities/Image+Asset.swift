//
//  Image+Asset.swift
//  Rimichka
//
//  Created by Alexander Ignatov on 22.07.20.
//  Copyright © 2020 Yalishanda. All rights reserved.
//

import SwiftUI

extension Image {
    enum Asset {
        static let icon = Image("landkon")
        static let filledHeart = Image(systemName: "heart.fill")
        static let emptyHeart = Image(systemName: "heart")
        static let searchHeart = Image("search-heart")
        static let searchMore = Image("search-more-glyph")
    }
}
