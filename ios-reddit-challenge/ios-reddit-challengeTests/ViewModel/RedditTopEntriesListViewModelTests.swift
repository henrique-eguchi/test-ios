//
//  RedditTopEntriesListViewModelTests.swift
//  ios-reddit-challengeTests
//
//  Created by Henrique Akiyoshi Eguchi on 07/05/21.
//

import XCTest
import Moya
@testable import ios_reddit_challenge

class RedditTopEntriesListViewModelTests: XCTestCase {

    func testEntriesLoadedSuccessfully() throws {
        let managerMock = RedditNetworkManager()
        managerMock.provider = MoyaProvider<RedditAPI>(stubClosure: MoyaProvider.immediatelyStub, plugins: [NetworkLoggerPlugin()])

        let delegateSpy = TopEntriesFetchingDelegateSpy()

        let expectation = expectation(description: "TopEntriesFetchingDelegate calls the delegate as the result of an async method completion")
        delegateSpy.asyncExpectation = expectation

        let sut = RedditTopEntriesListViewModel(networkManager: managerMock)

        sut.topEntriesFetchingDelegate = delegateSpy
        sut.fetchTopEntries()

        waitForExpectations(timeout: 1) { [weak sut] error in
            if let error = error {
                XCTFail("waitForExpectations errored: \(error)")
            }

            XCTAssertTrue(sut!.entriesCount() > 0)
            XCTAssertTrue(sut!.entriesCount() == 10)
        }
    }
    
    func testEntriesCountIncrementWhenFetchingTwiceSuccessfully() throws {
        let managerMock = RedditNetworkManager()
        managerMock.provider = MoyaProvider<RedditAPI>(stubClosure: MoyaProvider.immediatelyStub, plugins: [NetworkLoggerPlugin()])

        let delegateSpy = TopEntriesFetchingDelegateSpy()

        let expectation = expectation(description: "TopEntriesFetchingDelegate calls the delegate as the result of an async method completion")
        delegateSpy.asyncExpectation = expectation

        let sut = RedditTopEntriesListViewModel(networkManager: managerMock)

        sut.topEntriesFetchingDelegate = delegateSpy
        sut.fetchTopEntries()

        waitForExpectations(timeout: 1) { [weak self, delegateSpy, sut] error in
            if let error = error {
                XCTFail("waitForExpectations errored: \(error)")
            }

            XCTAssertTrue(sut.entriesCount() == 10)
            
            let expectation2 = self?.expectation(description: "TopEntriesFetchingDelegate another calls the delegate as the result of an async method completion")
            delegateSpy.asyncExpectation = expectation2
            
            sut.fetchTopEntries()

            self?.waitForExpectations(timeout: 1) { error in
                if let error = error {
                    XCTFail("waitForExpectations errored: \(error)")
                }

                XCTAssertTrue(sut.entriesCount() == 20)
            }
        }
    }
    
    func testShouldNotFetchAndIncrementWhenEntriesReach50Items() throws {
        let managerMock = RedditNetworkManager()
        managerMock.provider = MoyaProvider<RedditAPI>(stubClosure: MoyaProvider.immediatelyStub, plugins: [NetworkLoggerPlugin()])

        let delegateSpy = TopEntriesFetchingDelegateSpy()

        let expectation = expectation(description: "TopEntriesFetchingDelegate calls the delegate as the result of an async method completion")
        delegateSpy.asyncExpectation = expectation

        let sut = RedditTopEntriesListViewModel(networkManager: managerMock)

        sut.topEntriesFetchingDelegate = delegateSpy
        sut.fetchTopEntries()

        waitForExpectations(timeout: 1) { [weak self, delegateSpy, sut] error in
            if let error = error {
                XCTFail("waitForExpectations errored: \(error)")
            }

            XCTAssertTrue(sut.entriesCount() == 10)
            
            let expectation2 = self?.expectation(description: "TopEntriesFetchingDelegate another calls the delegate as the result of an async method completion")
            delegateSpy.asyncExpectation = expectation2
            
            sut.fetchTopEntries()

            self?.waitForExpectations(timeout: 1) { error in
                if let error = error {
                    XCTFail("waitForExpectations errored: \(error)")
                }

                XCTAssertTrue(sut.entriesCount() == 20)
                
                let expectation3 = self?.expectation(description: "TopEntriesFetchingDelegate third call the delegate as the result of an async method completion")
                delegateSpy.asyncExpectation = expectation3
                
                sut.fetchTopEntries()

                self?.waitForExpectations(timeout: 1) { error in
                    if let error = error {
                        XCTFail("waitForExpectations errored: \(error)")
                    }

                    XCTAssertTrue(sut.entriesCount() == 30)
                    
                    let expectation4 = self?.expectation(description: "TopEntriesFetchingDelegate fourth call the delegate as the result of an async method completion")
                    delegateSpy.asyncExpectation = expectation4
                    
                    sut.fetchTopEntries()

                    self?.waitForExpectations(timeout: 1) { error in
                        if let error = error {
                            XCTFail("waitForExpectations errored: \(error)")
                        }

                        XCTAssertTrue(sut.entriesCount() == 40)
                        
                        let expectation5 = self?.expectation(description: "TopEntriesFetchingDelegate fifth call the delegate as the result of an async method completion")
                        delegateSpy.asyncExpectation = expectation5
                        
                        sut.fetchTopEntries()

                        self?.waitForExpectations(timeout: 1) { error in
                            if let error = error {
                                XCTFail("waitForExpectations errored: \(error)")
                            }

                            XCTAssertTrue(sut.entriesCount() == 50)
                            
                                                        
                            sut.fetchTopEntries()
                            // MARK: - Should not fetch
                            XCTAssertTrue(sut.entriesCount() == 50)
                        }
                    }
                }
            }
        }
    }
}

class TopEntriesFetchingDelegateSpy: TopEntriesFetchingDelegate {
    func fetchSuccess() {
        asyncExpectation?.fulfill()
    }
    
    func fetchFailure() {
        asyncExpectation?.fulfill()
    }

    var asyncExpectation: XCTestExpectation?
}
