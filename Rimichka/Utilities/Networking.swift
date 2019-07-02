//
//  Networking.swift
//  Rimichka
//
//  Created by Alexander on 4.03.19.
//  Copyright © 2019 Yalishanda. All rights reserved.
//

import Foundation
import UIKit

class Networking {
  static let shared = Networking()
  private init() {}
  
  func getData(from url: URL, completion: @escaping (Data?) -> ()) {
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
    
    URLSession.shared.dataTask(with: url) {
      (data, _, error) in
      DispatchQueue.main.async {
        completion(data)
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
      }
      }.resume()
  }
  
  func getRhymesForWord(word: String, completion: @escaping (RhymesList?) -> ()) {
    guard let url = URL(string: "http://rimichka.com/?word=\(word)&json=1".URLescaped) else {
      print("invalid URL!")
      completion(nil)
      return
    }
    
    getData(from: url) { (data) in
      if let data = data {
        let rhymes = try? JSONDecoder().decode(RhymesList.self, from: data)
        completion(rhymes)
      } else {
        completion(nil)
      }
    }
  }
}
