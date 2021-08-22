//
//  APIError+message.swift
//  Rimichka
//
//  Created by Alexander Ignatov on 22.08.21.
//  Copyright © 2021 Yalishanda. All rights reserved.
//

import Foundation

extension APIError {
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
