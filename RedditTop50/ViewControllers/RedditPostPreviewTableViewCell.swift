//
//  RedditPostPreviewTableViewCell.swift
//  RedditTop50
//
//  Created by Nicolas Viegas Palermo on 09/03/2020.
//  Copyright © 2020 Nicolas Viegas Palermo. All rights reserved.
//

import UIKit

class RedditPostPreviewTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    func setup(withRedditPostPreview redditPostPreview: RedditPostPreview) {
        userNameLabel.text = redditPostPreview.author
        titleLabel.text = redditPostPreview.title
        thumbnailImageView.load(fromURL: redditPostPreview.thumbnailURL)
    }
}
