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

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let redditDetailViewController = RedditDetailViewController.instantiate()
        
        // TODO: - Setup viewmodel
        
        // TODO: - setup delegates

        self.redditDetailViewController = redditDetailViewController
        navigationController.pushViewController(redditDetailViewController, animated: true)
    }
    
    
}
