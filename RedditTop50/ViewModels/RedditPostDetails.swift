//
//  RedditPostDetails.swift
//  RedditTop50
//
//  Created by Nicolas Viegas Palermo on 09/03/2020.
//  Copyright © 2020 Nicolas Viegas Palermo. All rights reserved.
//

import Foundation

struct RedditPostDetails {
    let author: String
    let title: String
    let photoURL: URL?
}

extension RedditPostDetails: RedditPostViewModel {
    static func from(redditPost: RedditPost) -> RedditPostViewModel {
        return RedditPostDetails(author: redditPost.author,
                                 title: redditPost.title,
                                 photoURL: redditPost.thumbnail)
    }
}
