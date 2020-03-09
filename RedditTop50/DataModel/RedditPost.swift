//
//  RedditPost.swift
//  RedditTop50
//
//  Created by Nicolas Viegas Palermo on 09/03/2020.
//  Copyright © 2020 Nicolas Viegas Palermo. All rights reserved.
//

import Foundation

class RedditPost: Codable {
    var id: String
    var title: String
    var description: String
    var thumbnail: URL?
    var numberOfComments: String
    private var created: Int64
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case description
        case thumbnail
        case created
        case numberOfComments = "num_comments"
    }
    
    func creationDate() -> Date {
        return Date(timeIntervalSince1970: TimeInterval(created))
    }
}
