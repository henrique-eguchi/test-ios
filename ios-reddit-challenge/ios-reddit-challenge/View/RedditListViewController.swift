//
//  RedditListViewController.swift
//  ios-reddit-challenge
//
//  Created by Henrique Akiyoshi Eguchi on 05/05/21.
//

import UIKit

class RedditListViewController: UIViewController, Storyboarded {

    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!

    var viewModel: RedditTopEntriesListViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension RedditListViewController: TopEntriesFetchingDelegate {
    func fetchSuccess() {
        tableView.reloadData()
    }
    
    func fetchFailure() {
        // TODO: - Failure / Alert
    }
}
