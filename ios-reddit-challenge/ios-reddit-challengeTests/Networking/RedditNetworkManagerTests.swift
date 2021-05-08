//
//  RedditNetworkManagerTests.swift
//  ios-reddit-challengeTests
//
//  Created by Henrique Akiyoshi Eguchi on 07/05/21.
//

import XCTest
import Moya
@testable import ios_reddit_challenge

class RedditNetworkManagerTests: XCTestCase {

    func testSuccessfulEntriesFetch() throws {
        let sut = RedditNetworkManager()
        sut.provider = MoyaProvider<RedditAPI>(stubClosure: MoyaProvider.immediatelyStub, plugins: [NetworkLoggerPlugin()])
        
        sut.listTopEntries(limit: 10, after: String(), offset: 0) { result in
            switch result {
            case .success(let redditList):
                XCTAssertEqual(redditList.entries[0].title, "STUB - I’ve found a few funny memories during lockdown. This is from my 1st tour in 89, backstage in Vegas.")
            case .failure(_):
                XCTFail("Entries fetch failed!")
            }
        }
    }
}
