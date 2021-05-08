//
//  TopEntryCellViewModel.swift
//  ios-reddit-challenge
//
//  Created by Henrique Akiyoshi Eguchi on 07/05/21.
//

import Foundation

struct TopEntryCellViewModel {
    let id, title, author: String
    let thumbnail: URL?
    let commentsCount: Int
    let entryDate: String
    
    init(for redditEntry: RedditChildren) {
        self.id = redditEntry.id
        self.title = redditEntry.title
        self.author = redditEntry.author
        self.thumbnail = redditEntry.thumbnail
        self.commentsCount = redditEntry.commentsCount
        self.entryDate = Date(timeIntervalSince1970: redditEntry.entryDate).asStringRepresentation()
    }
}
