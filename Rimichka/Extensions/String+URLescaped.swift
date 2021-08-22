//
//  String+URLescaped.swift
//  Rimichka
//
//  Created by Alexander on 7.03.19.
//  Copyright © 2019 Yalishanda. All rights reserved.
//

import Foundation

extension String {
  var URLescaped: String {
    return self.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
  }
}
