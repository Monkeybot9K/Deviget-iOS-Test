//
//  RedditPostsRepository.swift
//  RedditTop50
//
//  Created by Nicolas Viegas Palermo on 09/03/2020.
//  Copyright © 2020 Nicolas Viegas Palermo. All rights reserved.
//

import Foundation

protocol RedditPostsRepository {
    // Read
    func getTop() -> [RedditPostPreview]
    func getDetails(forRedditPostWithId id: String) -> RedditPostDetails?
    
    // Write
    func setPosts(redditPosts: [RedditPost])
    func markPostAsRead(redditPostId id: String)
    func dismiss(redditPostId id: String)
    func dismissAll()
}

/// In memory Reddit Post Repository
class RedditPosts: RedditPostsRepository {
    private var redditPosts: [RedditPost] = []
    
    // Read
    func getTop() -> [RedditPostPreview] {
        return redditPosts.compactMap { RedditPostPreview.from(redditPost: $0) as? RedditPostPreview }
    }
    
    func getDetails(forRedditPostWithId id: String) -> RedditPostDetails? {
        guard let post = redditPosts.first(where: { $0.id == id }) else { return nil }
            
        return RedditPostDetails.from(redditPost: post) as? RedditPostDetails
    }
    
    // Write
    func setPosts(redditPosts: [RedditPost]) {
        
    }

    func markPostAsRead(redditPostId id: String) {
        
    }
    
    func dismiss(redditPostId id: String) {
        
    }
    
    func dismissAll() {
        
    }
}
