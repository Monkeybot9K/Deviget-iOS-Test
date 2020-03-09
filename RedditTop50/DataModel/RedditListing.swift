//
//  RedditListing.swift
//  RedditTop50
//
//  Created by Nicolas Viegas Palermo on 09/03/2020.
//  Copyright © 2020 Nicolas Viegas Palermo. All rights reserved.
//

import Foundation

struct RedditListing: Codable {
    let data: RedditListingData
}

struct RedditListingData: Codable {
    let children: [RedditPostData]
}

struct RedditPostData: Codable {
    let data: RedditPost
}
