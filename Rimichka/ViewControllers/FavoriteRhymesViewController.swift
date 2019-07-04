//
//  FavoriteRhymesViewController.swift
//  Rimichka
//
//  Created by Aleksandar Ignatov on 4.07.19.
//  Copyright © 2019 Yalishanda. All rights reserved.
//

import UIKit

class FavoriteRhymesViewController: UIViewController {
  
  // MARK: - Outlets
  @IBOutlet weak var tableView: UITableView!
  
  // MARK: - Properties
  private lazy var favoriteRhymes = FavoriteRhymes.shared
  private let cellIdentifier = "Favorite Rhymes Cell"
  
  // MARK: - View Controller Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    favoriteRhymes.addObserver(self)
    tableView.reloadData()
  }
}

// MARK: - Table View Data Source

extension FavoriteRhymesViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return favoriteRhymes.list.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? WordCell else {
      return UITableViewCell()
    }
    let rhyme = favoriteRhymes.list[indexPath.row]
    cell.nameLabel.text = "\(rhyme.parentWord ?? "") -> \(rhyme.word)"
    cell.markFavorite()
    cell.delegate = self
    return cell
  }
}

// MARK: - Table View Delegate

extension FavoriteRhymesViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    // TODO: navigate to the other view controller
  }
  
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return CGFloat.leastNormalMagnitude // removes redundant empty cells
  }
}

// MARK: - Favorite Rhymes Observer

extension FavoriteRhymesViewController: FavoriteRhymesObserver {
  func favoriteRhymesDidUpdate(_ newList: [RhymePair]) {
    tableView.reloadData()
  }
}

// MARK: - Word Cell Delegate

extension FavoriteRhymesViewController: WordCellDelegate {
  func wordCellDidToggleFavoriteStatus(_ cell: WordCell) {
    guard let indexPath = tableView.indexPath(for: cell) else { return }
    favoriteRhymes.remove(favoriteRhymes.list[indexPath.row])
  }
}
