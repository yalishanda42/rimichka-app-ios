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
  
  
  /// Fetch data asynchronously from any URL.
  ///
  /// - Parameters:
  ///   - url: The URL with the data to be fetched.
  ///   - completion: Completion handler closure with the fetched result (nil for failure).
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
  
  /// Fetch the rhymes for a given word from http://rimichka.com into a RhymesList object.
  ///
  /// - Parameters:
  ///   - word: The word to be rhymed, in Bulgarian.
  ///   - completion: Completion handler closure with the fetched result (nil for failure).
  func getRhymesForWord(word: String, completion: @escaping ([RhymePair]?) -> ()) {
    guard let url = URL(string: "http://rimichka.com/?word=\(word)&json=1".URLescaped) else {
      print("invalid URL!")
      completion(nil)
      return
    }
    
    getData(from: url) { (data) in
      if let data = data {
        var rhymesResult: [RhymePair] = []
        if let rhymes = try? JSONDecoder().decode([FetchedRhyme].self, from: data) {
          for rhyme in rhymes {
            if rhyme.wrd == word {
              continue
            }
            let rhymePair = RhymePair(word: rhyme.wrd, strength: rhyme.pri, parentWord: word)
            rhymesResult.append(rhymePair)
          }
          completion(rhymesResult)
        }
        completion(nil)
      } else {
        completion(nil)
      }
    }
  }
}
