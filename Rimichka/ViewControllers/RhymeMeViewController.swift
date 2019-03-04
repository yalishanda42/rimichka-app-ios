//
//  ViewController.swift
//  Rimichka
//
//  Created by Alexander on 4.03.19.
//  Copyright © 2019 Yalishanda. All rights reserved.
//

import UIKit

class RhymeMeViewController: UIViewController {

    @IBOutlet weak var rhymeInputField: UITextField!
    
    var rhymes: RhymesParser.Rhymes?
    
    @IBAction func onTapRhymeButton(_ sender: UIButton) {
        guard let rhyme = rhymeInputField.text else { return }
        
        RhymesParser.getRhymesForWord(word: rhyme) { [weak self] (result) in
            guard let result = result else {
                return
            }
            
            self?.rhymes = result
            self?.performSegue(withIdentifier: "showRhymesSegue", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? RhymesViewController {
            destination.rhymedWord = self.rhymeInputField.text!
            destination.rhymes = self.rhymes
        }
        
    }
    
}

