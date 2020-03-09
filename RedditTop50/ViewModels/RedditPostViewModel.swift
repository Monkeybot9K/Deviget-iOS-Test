//
//  RedditPostViewModel.swift
//  RedditTop50
//
//  Created by Nicolas Viegas Palermo on 09/03/2020.
//  Copyright © 2020 Nicolas Viegas Palermo. All rights reserved.
//

import Foundation

protocol RedditPostViewModel {
    static func from(redditPost: RedditPost) -> RedditPostViewModel
}
