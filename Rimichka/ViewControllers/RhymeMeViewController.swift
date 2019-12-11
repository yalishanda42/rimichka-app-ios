//
//  ViewController.swift
//  Rimichka
//
//  Created by Alexander on 4.03.19.
//  Copyright © 2019 Yalishanda. All rights reserved.
//

import UIKit

class RhymeMeViewController: UIViewController {
  
  // MARK: - Outlets
  
  @IBOutlet private weak var rhymeInput: UITextField!
  @IBOutlet private weak var tableView: UITableView!
  @IBOutlet private weak var rhymeMeButton: UIButton!
  @IBOutlet private weak var searchBottomLine: UIView!
  
  // MARK: - Properties
  
  let cellIdentifier = "WordCell"
  
  private lazy var networking = Networking.shared
  private lazy var favoriteRhymes = FavoriteRhymes.shared

  private var rhymes: [RhymePair] = []
  private var lastSearchedWord: String?
  
  private var searchButtonIsHidden: Bool = true {
    didSet {
      rhymeMeButton.isHidden = searchButtonIsHidden
    }
  }
  
  private var bottomLineIsInFocusedState: Bool = false {
    didSet {
      searchBottomLine.backgroundColor = bottomLineIsInFocusedState ? UIColor(named: "Foreground") : UIColor(named: "BottomLineNotFocused")
    }
  }

  // MARK: - View Controller Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.delegate = self
    tableView.dataSource = self
    searchButtonIsHidden = true
    favoriteRhymes.addObserver(self)
  }
  
  //MARK: - Actions
  
  @IBAction func rhymeChanged(_ sender: UITextField) {
    if let searchWord = sender.text,
      let lastWord = lastSearchedWord,
      searchWord.lowercased() == lastWord.lowercased()
    {
      searchButtonIsHidden = true
    } else if let searchWord = sender.text, searchWord != "", searchButtonIsHidden {
      searchButtonIsHidden = false
    }
  }
  
  @IBAction func onTapRhymeButton(_ sender: UIButton) {
    guard let word = rhymeInput.text else { return }
    rhymeInput.resignFirstResponder()
    fetchAndPopulateRhymes(for: word)
  }
  
  // MARK: - Helper methods
  
  private func getRhyme(for indexPath: IndexPath) -> RhymePair {
    return rhymes[indexPath.row]
  }
  
  func fetchAndPopulateRhymes(for word: String) {
    rhymeInput.text = word  // sync the text field input with the current word being rhymed
    
    networking.getRhymesForWord(word: word) { [weak self] (result) in
      guard let self = self, let result = result else {
        // TODO: handle error
        return
      }
      
      DispatchQueue.main.async {
        self.rhymes = result
        for i in 0..<self.rhymes.count {
          self.rhymes[i].parentWord = word
        }
        // TODO: Get sorting options from user preferences?
        self.rhymes = self.rhymes.sorted { $0.strength > $1.strength }
        self.tableView.reloadData()
      }
    }
  }
}

// MARK: - Table View Data Source

extension RhymeMeViewController : UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return rhymes.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? WordCell else {
      return UITableViewCell()
    }
    
    let rhyme = getRhyme(for: indexPath)
    cell.delegate = self
    cell.nameLabel.text = rhyme.word
    if favoriteRhymes.contains(rhyme) {
      cell.markFavorite()
    } else {
      cell.markNotFavorite()
    }
    
    return cell
  }
}

// MARK: - Table View Delegate

extension RhymeMeViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return CGFloat.leastNormalMagnitude // hides the empty cell outlines
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let word = getRhyme(for: indexPath).word
    fetchAndPopulateRhymes(for: word)
  }
}

// MARK: - Word Cell Delegate

extension RhymeMeViewController: WordCellDelegate {
  func wordCellDidToggleFavoriteStatus(_ cell: WordCell) {
    guard let indexPath = tableView.indexPath(for: cell) else { return }
    let rhyme = getRhyme(for: indexPath)
    if favoriteRhymes.contains(rhyme) {
      cell.markNotFavorite()
      favoriteRhymes.remove(rhyme)
    } else {
      cell.markFavorite()
      favoriteRhymes.add(rhyme)
    }
  }
}

// MARK: - Text Field Delegate

extension RhymeMeViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    if let word = textField.text {
      searchButtonIsHidden = true
      fetchAndPopulateRhymes(for: word)
      lastSearchedWord = word
    }
    return false
  }
  
  func textFieldShouldClear(_ textField: UITextField) -> Bool {
    searchButtonIsHidden = true
    return true
  }
  
  func textFieldDidBeginEditing(_ textField: UITextField) {
    bottomLineIsInFocusedState = true
  }
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    bottomLineIsInFocusedState = false
  }
}

// MARK: - Favorite Rhymes Observer

extension RhymeMeViewController: FavoriteRhymesObserver {
  func favoriteRhymesDidUpdate(_ newList: [RhymePair]) {
    tableView.reloadData()
  }
}
