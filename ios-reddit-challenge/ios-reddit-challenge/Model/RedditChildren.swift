//
//  RedditChildren.swift
//  ios-reddit-challenge
//
//  Created by Henrique Akiyoshi Eguchi on 05/05/21.
//

import Foundation

struct RedditChildren {
    let id, title, author: String
    let thumbnail: URL?
    let commentsCount: Int
    let entryDate: Double
}

extension RedditChildren: Decodable {
    enum CodingKeys: String, CodingKey {
        case id, title, author
        case thumbnail
        case commentsCount = "num_comments"
        case entryDate = "created"

        case data
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let dataContainer = try values.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)

        id = try dataContainer.decode(String.self, forKey: .id)
        title = try dataContainer.decode(String.self, forKey: .title)
        author = try dataContainer.decode(String.self, forKey: .author)
        thumbnail = try dataContainer.decode(URL.self, forKey: .thumbnail)
        commentsCount = try dataContainer.decode(Int.self, forKey: .commentsCount)
        entryDate = try dataContainer.decode(Double.self, forKey: .entryDate)
    }
}
