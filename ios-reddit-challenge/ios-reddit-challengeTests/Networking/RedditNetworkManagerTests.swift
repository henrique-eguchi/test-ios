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
        
        sut.listTopEntries(count: 0, limit: 25) { result in
            switch result {
            case .success(let redditList):
                XCTAssertEqual(redditList.entries[0].title, "STUB - Welcome to the Ocean")
            case .failure(_):
                XCTFail("Entries fetch failed!")
            }
        }
    }
}
