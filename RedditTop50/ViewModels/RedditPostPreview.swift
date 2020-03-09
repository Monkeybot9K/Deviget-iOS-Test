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
    let description: String
    let thumbnailURL: URL?
    let posted: String
    let numberOfComments: String
}

extension RedditPostPreview: RedditPostViewModel {
    static func from(redditPost: RedditPost) -> RedditPostViewModel {
        return RedditPostPreview(title: redditPost.title,
                                 description: redditPost.description,
                                 thumbnailURL: redditPost.thumbnail,
                                 posted: "\(redditPost.creationDate())",
                                 numberOfComments: redditPost.numberOfComments)
    }
}
