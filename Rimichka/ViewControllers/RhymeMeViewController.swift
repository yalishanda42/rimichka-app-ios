//
//  ViewController.swift
//  Rimichka
//
//  Created by Alexander on 4.03.19.
//  Copyright © 2019 Yalishanda. All rights reserved.
//

import UIKit

class RhymeMeViewController: UIViewController {

    var rhymes: RhymesParser.Rhymes?
        
    @IBOutlet weak var rhymeInput: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func onTapRhymeButton(_ sender: UIButton) {
        guard let rhyme = rhymeInput.text else { return }
        
        RhymesParser.getRhymesForWord(word: rhyme) { [weak self] (result) in
            guard let result = result else {
                return
            }
            
            DispatchQueue.main.async {
                self?.rhymes = result
                self?.tableView.reloadData()
            }
            
        }
    }
}

