//
//  RedditListCoordinator.swift
//  ios-reddit-challenge
//
//  Created by Henrique Akiyoshi Eguchi on 05/05/21.
//

import UIKit

class RedditListCoordinator: Coordinator {
    var navigationController: UINavigationController
    private var redditListViewController: RedditListViewController?
    private var redditDetailCoordinator: RedditDetailCoordinator?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let redditListViewController = RedditListViewController.instantiate()
        
        // TODO: - Setup viewmodel
        
        // TODO: - setup delegates

        self.redditListViewController = redditListViewController
        navigationController.pushViewController(redditListViewController, animated: true)
    }
    
    
}
