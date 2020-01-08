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
  @IBOutlet private weak var loadingIndicator: UIActivityIndicatorView!
  @IBOutlet private weak var noContentLabel: UILabel!
  
  // MARK: - Properties
  
  let cellIdentifier = "WordCell"
  
  private let loadingFailedText = "Или няма рима, или няма интернет :("
  private let noResultsText = "Е това вече не мога да го римувам :/"
  
  private lazy var networking = Networking.shared
  private lazy var favoriteRhymes = FavoriteRhymes.shared
  
  private var searchState: SearchState = .initial {
    didSet {
      if searchState == .loading {
        loadingIndicator.startAnimating()
      } else {
        loadingIndicator.stopAnimating()
      }
      
      switch searchState {
      case .initial:
        noContentLabel.isHidden = true
        loadingIndicator.isHidden = true
        tableView.isHidden = true
      case .loading:
        noContentLabel.isHidden = true
        loadingIndicator.isHidden = false
        tableView.isHidden = true
      case .hasResults:
        noContentLabel.isHidden = true
        loadingIndicator.isHidden = true
        tableView.isHidden = false
      case .noResults, .loadingFailed:
        noContentLabel.isHidden = false
        loadingIndicator.isHidden = true
        tableView.isHidden = true
      }
      
      switch searchState {
      case .noResults:
        noContentLabel.text = noResultsText
      case .loadingFailed:
        noContentLabel.text = loadingFailedText
      default:
        noContentLabel.text = nil
      }
    }
  }

  private var rhymes: [RhymePair] = []
  private var lastSearchedWord: String?
  
  private var searchButtonIsHidden: Bool = true {
    didSet {
      rhymeMeButton.isHidden = searchButtonIsHidden
    }
  }
  
  private var bottomLineIsInFocusedState: Bool = false {
    didSet {
        searchBottomLine.backgroundColor = bottomLineIsInFocusedState ? UIColor(red: 1.0, green: 54.0 / 255.0, blue: 67.0 / 255.0, alpha: 1) : UIColor(red: 60.0 / 255.0, green: 60.0 / 255.0 , blue: 67.0 / 255.0, alpha: 0.3)
    }
  }

  // MARK: - View Controller Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.delegate = self
    tableView.dataSource = self
    searchButtonIsHidden = true
    searchState = .initial
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
    searchButtonIsHidden = true
    fetchAndPopulateRhymes(for: word)
  }
  
  // MARK: - Helper methods
  
  private func getRhyme(for indexPath: IndexPath) -> RhymePair {
    return rhymes[indexPath.row]
  }
  
  func fetchAndPopulateRhymes(for word: String) {
    rhymeInput.text = word  // sync the text field input with the current word being rhymed
    
    searchState = .loading
    
    networking.getRhymesForWord(word: word) { [weak self] (result) in
      guard let self = self else { return }
      
      guard let result = result else {
        self.searchState = .loadingFailed
        return
      }
      
      DispatchQueue.main.async {
        self.rhymes = result
        for i in 0..<self.rhymes.count {
          self.rhymes[i].parentWord = word
        }
        self.rhymes = self.rhymes.sorted { $0.strength > $1.strength }
        
        self.tableView.reloadData()
        
        self.searchState = result.count == 0 ? .noResults : .hasResults
      }
    }
  }
}

extension RhymeMeViewController {
  enum SearchState {
    case initial
    case loading
    case loadingFailed
    case hasResults
    case noResults
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
