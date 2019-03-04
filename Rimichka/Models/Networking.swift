//
//  Networking.swift
//  Rimichka
//
//  Created by Alexander on 4.03.19.
//  Copyright © 2019 Yalishanda. All rights reserved.
//

import Foundation
import UIKit

final class Networking {
    static let shared = Networking()
    private init() {}
    
    static func getData(from url: URL, completion: @escaping (Data?) -> ()) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        URLSession.shared.dataTask(with: url) {
            (data, _, error) in
            DispatchQueue.main.async {
                completion(data)
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        }.resume()
    }
}
