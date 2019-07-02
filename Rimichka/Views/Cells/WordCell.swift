//
//  WordCell.swift
//  Rimichka
//
//  Created by Alexander on 5.03.19.
//  Copyright © 2019 Yalishanda. All rights reserved.
//

import UIKit

protocol WordCellDelegate: class {
  func wordCellDidToggleFavoriteStatus(_ cell: WordCell)
}

class WordCell : UITableViewCell {
  
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var favoriteButton: UIButton!
  
  weak var delegate: WordCellDelegate?
  
  @IBAction func onTapFavoriteButton(_ sender: UIButton) {
    delegate?.wordCellDidToggleFavoriteStatus(self)
  }
  
  func markFavorite() {
    favoriteButton.setImage(#imageLiteral(resourceName: "like-filled"), for: .normal)
  }
  
  func markNotFavorite() {
    favoriteButton.setImage(#imageLiteral(resourceName: "like"), for: .normal)
  }
}
