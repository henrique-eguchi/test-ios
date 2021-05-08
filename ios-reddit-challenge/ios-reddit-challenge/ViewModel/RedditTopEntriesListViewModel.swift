//
//  RedditTopEntriesListViewModel.swift
//  ios-reddit-challenge
//
//  Created by Henrique Akiyoshi Eguchi on 07/05/21.
//

import Foundation

protocol TopEntriesFetchingDelegate: AnyObject {
    func fetchSuccess()
    func fetchFailure()
}

protocol TopEntriesNavigationDelegate: AnyObject {
    func entrySelected(_ entry: RedditChildren)
}

class RedditTopEntriesListViewModel {
    private let kDefaultPageLimit = 10
    private let kMaxEntries = 50
    private var offset = 0
    private var after = String()
    public var isFetching = false

    private var entries: [RedditChildren]
    private var networkManager: RedditNetworkManager
    
    weak var topEntriesFetchingDelegate: TopEntriesFetchingDelegate?
    weak var topEntriesNavigationDelegate: TopEntriesNavigationDelegate?

    init(networkManager: RedditNetworkManager) {
        self.entries = []
        self.networkManager = networkManager
    }
    
    func fetchTopEntries() {
        guard !isFetching && offset < kMaxEntries else { return }

        isFetching = true
        let optionalOffset: Int? = offset == 0 ? nil : offset
        
        networkManager.listTopEntries(limit: kDefaultPageLimit, after: after, offset: optionalOffset) { [weak self] result in
            guard let self = self else { return }

            self.isFetching = false

            switch result {
            case .success(let response):
                self.offset += response.entries.count
                self.after = response.after ?? String()
                self.entries.append(contentsOf: response.entries)
                DispatchQueue.main.async {
                    self.topEntriesFetchingDelegate?.fetchSuccess()
                }
            case .failure:
                self.topEntriesFetchingDelegate?.fetchFailure()
            }
            
        }
    }

    func entriesCount() -> Int {
        entries.count
    }

    func viewModelForItemAt(indexPath: IndexPath) -> TopEntryCellViewModel? {
        guard entries.count > indexPath.row else { return nil }
        let entry = entries[indexPath.row]
        return TopEntryCellViewModel(for: entry)
    }

    func showEntryDetailsAt(indexPath: IndexPath) {
        let entry = entries[indexPath.row]
        topEntriesNavigationDelegate?.entrySelected(entry)
    }

    func resetPagination() {
        offset = 0
        after = String()
        isFetching = false
        entries = []
    }
}
