//
//  RedditList.swift
//  ios-reddit-challenge
//
//  Created by Henrique Akiyoshi Eguchi on 05/05/21.
//

import Foundation

struct RedditList {
    var entries = [RedditChildren]()
}

extension RedditList: Decodable {
    enum CodingKeys: String, CodingKey {
        case entries = "children"
        case data
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let data = try values.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
        
        entries = try data.decode([RedditChildren].self, forKey: .entries)
    }
}
