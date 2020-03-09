//
//  Top50ViewController.swift
//  RedditTop50
//
//  Created by Nicolas Viegas Palermo on 09/03/2020.
//  Copyright © 2020 Nicolas Viegas Palermo. All rights reserved.
//

import UIKit

protocol SelectionDelegate {
    func didSelectPost(withId id: String)
}

// MARK - Class Implementation
class Top50ViewController: UIViewController {
    var selectionDelegate: SelectionDelegate? = nil
}

// MARK - Data Source
extension Top50ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "RedditPostPreviewCell")!
    }
}


// MARK - Delegate
extension Top50ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let detailViewController = self.selectionDelegate as? PostDetailViewController {
            detailViewController.didSelectPost(withId: "\(indexPath.row)")
            splitViewController?.showDetailViewController(detailViewController, sender: nil)
        }
    }
}
