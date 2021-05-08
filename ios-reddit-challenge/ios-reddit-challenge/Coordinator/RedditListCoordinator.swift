//
//  RedditListCoordinator.swift
//  ios-reddit-challenge
//
//  Created by Henrique Akiyoshi Eguchi on 05/05/21.
//

import UIKit
import Moya

class RedditListCoordinator: Coordinator {
    var navigationController: UINavigationController
    private var redditListViewController: RedditListViewController?
    private var redditDetailCoordinator: RedditDetailCoordinator?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let redditListViewController = RedditListViewController.instantiate()

        let networkManager = RedditNetworkManager()
        
        let redditTopEntriesListViewModel = RedditTopEntriesListViewModel(networkManager: networkManager)
        redditListViewController.viewModel = redditTopEntriesListViewModel
        redditListViewController.title = "Top entries"

        redditTopEntriesListViewModel.topEntriesFetchingDelegate = redditListViewController
        redditTopEntriesListViewModel.topEntriesNavigationDelegate = self

        self.redditListViewController = redditListViewController
        navigationController.pushViewController(redditListViewController, animated: true)
    }
}

extension RedditListCoordinator: TopEntriesNavigationDelegate {
    func entrySelected(_ entry: RedditChildren) {
        let redditDetailCoordinator = RedditDetailCoordinator(navigationController: navigationController, redditChildren: entry)
        redditDetailCoordinator.start()
    }
    
    
}
