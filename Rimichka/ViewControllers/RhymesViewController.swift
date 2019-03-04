//
//  RhymesViewController.swift
//  Rimichka
//
//  Created by Alexander on 4.03.19.
//  Copyright © 2019 Yalishanda. All rights reserved.
//

import UIKit
import Foundation

class RhymesViewController: UITableViewController {
    
    var rhymedWord: String!
    var rhymes: RhymesParser.Rhymes!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return rhymes.rhymes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "WordCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? WordCell else {
            return UITableViewCell()
        }
        
        cell.nameLabel.text = rhymes.rhymes[indexPath.row].word
        return cell
    }
    
    
}
