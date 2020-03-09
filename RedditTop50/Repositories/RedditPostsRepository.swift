//
//  RedditPostsRepository.swift
//  RedditTop50
//
//  Created by Nicolas Viegas Palermo on 09/03/2020.
//  Copyright © 2020 Nicolas Viegas Palermo. All rights reserved.
//

import Foundation

protocol RedditPostsRepository {
    var redditPosts: [RedditPost] { get }
    
    // Read
    func getPreview(atIndex index: Int) -> RedditPostPreview?
    func getDetails(forRedditPostWithId id: String) -> RedditPostDetails?
    
    // Write
    func setPosts(redditPosts: [RedditPost])
    func markPostAsRead(redditPostId id: String)
    func dismiss(redditPostId id: String)
    func dismissAll()
}

/// In memory Reddit Post Repository
class RedditPosts: RedditPostsRepository {
    private(set) var redditPosts: [RedditPost] = []
    
    // Read
    func getPreview(atIndex index: Int) -> RedditPostPreview? {
        return RedditPostPreview.from(redditPost: redditPosts[index]) as? RedditPostPreview
    }
    
    func getDetails(forRedditPostWithId id: String) -> RedditPostDetails? {
        guard let post = redditPosts.first(where: { $0.id == id }) else { return nil }
            
        return RedditPostDetails.from(redditPost: post) as? RedditPostDetails
    }
    
    // Write
    func setPosts(redditPosts: [RedditPost]) {
        self.redditPosts = redditPosts
    }

    func markPostAsRead(redditPostId id: String) {
        
    }
    
    func dismiss(redditPostId id: String) {
        redditPosts.removeAll { $0.id == id }
    }
    
    func dismissAll() {
        redditPosts = []
    }
}
