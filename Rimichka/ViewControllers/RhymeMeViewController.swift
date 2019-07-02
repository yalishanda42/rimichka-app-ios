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
  
  @IBOutlet weak var rhymeInput: UITextField!
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var rhymeMeButton: UIButton!
  
  // MARK: - Properties
  
  let cellIdentifier = "WordCell"
  
  private lazy var networking = Networking.shared
  private var rhymes: RhymesList?

  // MARK: - View Controller Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.delegate = self
    tableView.dataSource = self
    rhymeMeButton.alpha = 0
  }
  
  //MARK: - Actions
  
  @IBAction func rhymeChanged(_ sender: Any) {
    rhymeMeButton.alpha = 1
  }
  
  @IBAction func onTapRhymeButton(_ sender: UIButton) {
    guard let rhyme = rhymeInput.text else { return }
    fetchAndPopulateRhymes(for: rhyme)
  }
  
  // MARK: - Helper methods
  
  private func getRhyme(for indexPath: IndexPath) -> RhymesList.Rhyme? {
    return rhymes?[indexPath.row]
  }
  
  private func fetchAndPopulateRhymes(for word: String) {
    rhymeInput.text = word  // sync the text field input with the current word being rhymed
    rhymeMeButton.alpha = 0
    
    networking.getRhymesForWord(word: word) { [weak self] (result) in
      guard let self = self, let result = result else {
        // TODO: handle error
        return
      }
      
      DispatchQueue.main.async {
        self.rhymes = result
        // TODO: Get sorting options from user preferences
        self.rhymes?.list = result.list.sorted { $0.strength > $1.strength }
        self.tableView.reloadData()
      }
    }
  }
}

// MARK: - Table View Data Source

extension RhymeMeViewController : UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return rhymes?.list.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? WordCell else {
      return UITableViewCell()
    }
    cell.delegate = self
    cell.nameLabel.text = getRhyme(for: indexPath)?.word
    return cell
  }
}

// MARK: - Table View Delegate

extension RhymeMeViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return CGFloat.leastNormalMagnitude // hides the empty cell outlines
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let rhyme = getRhyme(for: indexPath)?.word else { return }
    fetchAndPopulateRhymes(for: rhyme)
  }
}

// MARK: - Word Cell Delegate

extension RhymeMeViewController: WordCellDelegate {
  func wordCellDidToggleFavoriteStatus(_ cell: WordCell) {
    guard let indexPath = tableView.indexPath(for: cell) else { return }
    // TODO: Implement favorite cells
  }
}
