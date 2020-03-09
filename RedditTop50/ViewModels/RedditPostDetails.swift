//
//  RedditPostDetails.swift
//  RedditTop50
//
//  Created by Nicolas Viegas Palermo on 09/03/2020.
//  Copyright © 2020 Nicolas Viegas Palermo. All rights reserved.
//

import Foundation

struct RedditPostDetails {
    let title: String
    let description: String
    let photoURL: URL?
}

extension RedditPostDetails: RedditPostViewModel {
    static func from(redditPost: RedditPost) -> RedditPostViewModel {
        return RedditPostDetails(title: redditPost.subreddit,
                                 description: redditPost.title,
                                 photoURL: redditPost.thumbnail)
    }
}
