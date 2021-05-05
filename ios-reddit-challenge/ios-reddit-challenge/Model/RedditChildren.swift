//
//  RedditChildren.swift
//  ios-reddit-challenge
//
//  Created by Henrique Akiyoshi Eguchi on 05/05/21.
//

import Foundation

struct RedditChildren: Codable {
    let title, author: String
    let thumbnail: String
    let commentsCount: Int
    let entryDate: Int

    enum CodingKeys: String, CodingKey {
        case title, author
        case thumbnail
        case commentsCount = "num_comments"
        case entryDate = "created"
    }
}
