//
//  View+eraseToAnyView.swift
//  Rimichka
//
//  Created by Alexander Ignatov on 26.07.20.
//  Copyright © 2020 Yalishanda. All rights reserved.
//

import SwiftUI

extension View {
    func eraseToAnyView() -> AnyView {
        AnyView(self)
    }
}
