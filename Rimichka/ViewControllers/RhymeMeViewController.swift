//
//  ViewController.swift
//  Rimichka
//
//  Created by Alexander on 4.03.19.
//  Copyright © 2019 Yalishanda. All rights reserved.
//

import UIKit

class RhymeMeViewController: UIViewController {

    // MARK: Vars
    var rhymes: RhymesParser.Rhymes?
    
    // MARK: IB Outlets
    @IBOutlet weak var rhymeInput: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var rhymeMeButton: UIButton!
    
    // MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        rhymeMeButton.alpha = 0
    }
    //MARK: IB Actions
    
    @IBAction func rhymeChanged(_ sender: Any) {
        rhymeMeButton.alpha = 1
    }
    
    @IBAction func onTapRhymeButton(_ sender: UIButton) {
        guard let rhyme = rhymeInput.text else { return }
        fetchAndPopulateRhymes(for: rhyme)
    }
    
    // MARK: Helper function
    func fetchAndPopulateRhymes(for word: String) {
        rhymeInput.text = word
        rhymeMeButton.alpha = 0
        
        RhymesParser.getRhymesForWord(word: word) { [weak self] (result) in
            guard let result = result else {
                return
            }
            
            DispatchQueue.main.async {
                self?.rhymes = result
                // TODO: Get sorting options from user preferences
                self?.rhymes?.rhymes = result.rhymes.sorted { $0.strength ?? 0 > $1.strength ?? 0 }
                self?.tableView.reloadData()
            }
            
        }
    }
}

// MARK: Table View Data Source Extension
extension RhymeMeViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rhymes?.rhymes.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "WordCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? WordCell else {
            return UITableViewCell()
        }
        
        cell.nameLabel.text = rhymes?.rhymes[indexPath.row].word
        return cell
    }
}


// MARK: Table View Delegate
extension RhymeMeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    // TODO: Search for word in selected cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let rhyme = rhymes?.rhymes[indexPath.row].word else { return }
        fetchAndPopulateRhymes(for: rhyme)
    }
}
