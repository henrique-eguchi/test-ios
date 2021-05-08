//
//  AppCoordinator.swift
//  ios-reddit-challenge
//
//  Created by Henrique Akiyoshi Eguchi on 05/05/21.
//

import UIKit

class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    let redditListCoordinator: RedditListCoordinator

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController

        redditListCoordinator = RedditListCoordinator(navigationController: navigationController)
    }

    func start() {
        redditListCoordinator.start()
    }
}
