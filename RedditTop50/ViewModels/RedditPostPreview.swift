//
//  RedditPostPreview.swift
//  RedditTop50
//
//  Created by Nicolas Viegas Palermo on 09/03/2020.
//  Copyright © 2020 Nicolas Viegas Palermo. All rights reserved.
//

import Foundation

struct RedditPostPreview {
    let title: String
    let author: String
    let thumbnailURL: URL?
    let posted: String
    let numberOfComments: String
    var read: Bool
    
    init(title: String,
          author: String,
          thumbnailURL: URL?,
          creationDate: Date,
          numberOfComments: Int64,
          read: Bool) {
        
        self.title = title
        self.author = author
        self.thumbnailURL = thumbnailURL
        self.numberOfComments = "\(numberOfComments) Comments"
        
        let dateComponents = Calendar.current.dateComponents([.hour], from: creationDate, to: Date())
        self.posted = "\(dateComponents.hour ?? 0) hours ago."
        self.read = read
    }
}

extension RedditPostPreview: RedditPostViewModel {
    static func from(redditPost: RedditPost) -> RedditPostViewModel {
        return RedditPostPreview(title: redditPost.title,
                                 author: redditPost.author,
                                 thumbnailURL: redditPost.thumbnail,
                                 creationDate: redditPost.creationDate(),
                                 numberOfComments: redditPost.numberOfComments,
                                 read: false)
    }
}
