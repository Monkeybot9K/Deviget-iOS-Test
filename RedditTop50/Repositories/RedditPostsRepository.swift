//
//  RedditPostsRepository.swift
//  RedditTop50
//
//  Created by Nicolas Viegas Palermo on 09/03/2020.
//  Copyright © 2020 Nicolas Viegas Palermo. All rights reserved.
//

import Foundation

protocol RedditPostDetailsProvider {
    func getDetails(forRedditPostWithId id: String) -> RedditPostDetails?
}

protocol RedditPostsRepository: RedditPostDetailsProvider {
    var redditPosts: [RedditPost] { get }
    
    // Read
    func getPreview(atIndex index: Int) -> RedditPostPreview?
    func getDetails(forRedditPostWithId id: String) -> RedditPostDetails?
    
    // Write
    func setPosts(redditPosts: [RedditPost])
    func markPostAsRead(atIndex index: Int)
    func dismiss(redditPostAtIndex index: Int)
    func dismissAll()
}

/// In memory Reddit Post Repository
class RedditPosts: RedditPostsRepository {
    private(set) var redditPosts: [RedditPost] = []
    private var readPostIds: Set<String> = []
    
    // Read
    func getPreview(atIndex index: Int) -> RedditPostPreview? {
        guard var preview = RedditPostPreview.from(redditPost: redditPosts[index]) as? RedditPostPreview else { return nil }
        preview.read = readPostIds.contains(redditPosts[index].id)
        return preview
    }
    
    func getDetails(forRedditPostWithId id: String) -> RedditPostDetails? {
        guard let post = redditPosts.first(where: { $0.id == id }) else { return nil }
            
        return RedditPostDetails.from(redditPost: post) as? RedditPostDetails
    }
    
    // Write
    func setPosts(redditPosts: [RedditPost]) {
        self.redditPosts = redditPosts
    }

    func markPostAsRead(atIndex index: Int) {
        readPostIds.insert(redditPosts[index].id)
    }
    
    func dismiss(redditPostAtIndex index: Int) {
        redditPosts.remove(at: index)
    }
    
    func dismissAll() {
        redditPosts = []
    }
}
