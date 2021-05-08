//
//  RedditList.swift
//  ios-reddit-challenge
//
//  Created by Henrique Akiyoshi Eguchi on 05/05/21.
//

import Foundation

struct RedditList {
    var entries = [RedditChildren]()
    let after: String?
    let before: String?
}

extension RedditList: Decodable {
    enum CodingKeys: String, CodingKey {
        case entries = "children"
        case data
        case after, before
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let data = try values.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
        after = try data.decodeIfPresent(String.self, forKey: .after)
        before = try data.decodeIfPresent(String.self, forKey: .before)
        entries = try data.decode([RedditChildren].self, forKey: .entries)
    }
}
