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
        
        // Setup Service
        repository = RedditPosts()
        service = RedditService(withRedditRepository: repository)
        
        // Setup Refresh Control
        let refreshControl = UIRefreshControl()
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refresh(withControl:)), for: .valueChanged)
        
        // Initial Load
        refresh(withControl: refreshControl)
    }
    
    @IBAction func dismissAllButtonTapped(sender: UIBarButtonItem) {
        repository.dismissAll()
        tableView.reloadSections(IndexSet([0]), with: .automatic)
    }

    @objc func refresh(withControl refreshControl: UIRefreshControl) {
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
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                    refreshControl.endRefreshing()
                }
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            repository.dismiss(redditPostAtIndex: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Dismiss"
    }
}


// MARK - Delegate
extension Top50ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let detailViewController = self.selectionDelegate as? PostDetailViewController {
            
            // Show Post
            detailViewController.didSelectPost(withId: "\(indexPath.row)")
            splitViewController?.showDetailViewController(detailViewController, sender: nil)
            
            // Mark as read
            repository.markPostAsRead(atIndex: indexPath.row)
            tableView.reloadRows(at: [indexPath], with: .none)
        }
    }
}
