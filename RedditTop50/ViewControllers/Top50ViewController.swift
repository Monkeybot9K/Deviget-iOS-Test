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
    @IBOutlet weak var tableView: UITableView!
    
    var selectionDelegate: SelectionDelegate? = nil
    
    var repository: RedditPosts!
    var service: RedditService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        repository = RedditPosts()
        service = RedditService(withRedditRepository: repository)
        service.getTop(numberOfPosts: 50) { [weak self] (success, error) in
            guard error == nil else {
                let alert = UIAlertController(title: "Error",
                                              message: "An Error ocurred while attempting to retrieve top 50 reddit posts, please try again later",
                                              preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss",
                                              style: .cancel,
                                              handler: nil))
                self?.present(alert, animated: true, completion: nil)
                return
            }
            
            if success {
                self?.tableView.reloadData()
            }
        }
    }
}

// MARK - Data Source
extension Top50ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repository.redditPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "RedditPostPreviewCell") as? RedditPostPreviewTableViewCell,
            let preview = repository.getPreview(atIndex: indexPath.row)
            else { fatalError() }
        
        cell.setup(withRedditPostPreview: preview)
        return cell
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
