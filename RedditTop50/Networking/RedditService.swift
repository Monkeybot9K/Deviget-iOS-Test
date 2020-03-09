//
//  RedditService.swift
//  RedditTop50
//
//  Created by Nicolas Viegas Palermo on 09/03/2020.
//  Copyright © 2020 Nicolas Viegas Palermo. All rights reserved.
//

import Foundation

enum httpMethod: String {
    case GET
}

protocol Endpoint {
    var url: URL? { get }
    var method: httpMethod { get }
}

enum RedditEndpoint {
    case top(postCount: Int)
    
    var url: URL? {
        switch self {
        case .top(let postCount):
            return URL(string: "https://www.reddit.com/top.json?raw_json=1&limit=\(postCount)")
        }
    }
    
    var method: httpMethod {
        switch self {
        case .top(_):
            return .GET
        }
    }
}

typealias ServiceCompletionHandler = (_ success: Bool, _ error: Error?) -> ()

class RedditService {
    let repository: RedditPostsRepository
    
    init(withRedditRepository redditRepository: RedditPostsRepository) {
        self.repository = redditRepository
    }
    
    func getTop(numberOfPosts: Int, completion: ServiceCompletionHandler?) {
        let endpoint = RedditEndpoint.top(postCount: 50)
        guard let url = endpoint.url else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue

        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            do {
                guard let data = data else { return }
                
                let listing = try JSONDecoder().decode(RedditListing.self, from: data)
                let posts = listing.data.children.compactMap { $0.data }
                                
                DispatchQueue.main.async {
                    self?.repository.setPosts(redditPosts: posts)
                    completion?(true,  nil)
                }
            } catch {
                DispatchQueue.main.async {
                    completion?(false,  error)
                }
            }

        }

        task.resume()
    }
}
