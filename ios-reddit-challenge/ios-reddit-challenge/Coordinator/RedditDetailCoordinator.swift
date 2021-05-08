//
//  RedditDetailCoordinator.swift
//  ios-reddit-challenge
//
//  Created by Henrique Akiyoshi Eguchi on 05/05/21.
//

import UIKit

class RedditDetailCoordinator: Coordinator {

    var navigationController: UINavigationController
    private var redditDetailViewController: RedditDetailViewController?
    private let redditChildren: RedditChildren

    init(navigationController: UINavigationController,
         redditChildren: RedditChildren) {
        self.navigationController = navigationController
        self.redditChildren = redditChildren
    }
    
    func start() {
        let redditDetailViewController = RedditDetailViewController.instantiate()
        redditDetailViewController.title = "Details"
        redditDetailViewController.viewModel = RedditDetailViewModel(redditChildren: redditChildren)

        self.redditDetailViewController = redditDetailViewController
        navigationController.pushViewController(redditDetailViewController, animated: true)
    }
}
