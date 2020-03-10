//
//  PostDetailViewController.swift
//  RedditTop50
//
//  Created by Nicolas Viegas Palermo on 09/03/2020.
//  Copyright © 2020 Nicolas Viegas Palermo. All rights reserved.
//

import UIKit

class PostDetailViewController: UIViewController {
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    var detailsProvider: RedditPostDetailsProvider!
    private var redditPostId: String? = nil
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let id = redditPostId,
            let details = detailsProvider.getDetails(forRedditPostWithId: id) else { return }
        
        userNameLabel.text = details.author
        titleLabel.text = details.title
        thumbnailImageView.load(fromURL: details.photoURL)
    }
}

extension PostDetailViewController: SelectionDelegate {
    func didSelectPost(withId id: String) {
        redditPostId = id
    }
}
