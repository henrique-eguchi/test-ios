//
//  RedditList.swift
//  ios-reddit-challenge
//
//  Created by Henrique Akiyoshi Eguchi on 05/05/21.
//

import Foundation

struct RedditList {
    var posts = [RedditChildren]()
}

extension RedditList: Decodable {
    enum CodingKeys: String, CodingKey {
        case posts = "children"
        case data
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let data = try values.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
        
        posts = try data.decode([RedditChildren].self, forKey: .posts)
    }
}
