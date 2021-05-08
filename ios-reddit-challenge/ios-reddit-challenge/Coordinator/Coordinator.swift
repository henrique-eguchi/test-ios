//
//  Coordinator.swift
//  ios-reddit-challenge
//
//  Created by Henrique Akiyoshi Eguchi on 05/05/21.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }

    func start()
}
