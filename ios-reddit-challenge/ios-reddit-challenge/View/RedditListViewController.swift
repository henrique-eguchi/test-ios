//
//  RedditListViewController.swift
//  ios-reddit-challenge
//
//  Created by Henrique Akiyoshi Eguchi on 05/05/21.
//

import UIKit
import Kingfisher

class RedditListViewController: UIViewController, Storyboarded {

    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Dependencies
    
    var viewModel: RedditTopEntriesListViewModel?
    
    // MARK: - Constants
    
    let kZeroRow = 0
    let kOneRow = 1
    let kChildrenSection = 0
    let kLoadingSection = 1
    let kNumberOfSections = 2
    
    // MARK: - Plugins
    
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupRefreshControl()
        viewModel?.fetchTopEntries()
    }
    
    // MARK: - Setups
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self

        let redditChildrenNib = UINib(nibName: "RedditChildrenTableViewCell", bundle: nil)
        tableView.register(redditChildrenNib, forCellReuseIdentifier: RedditChildrenTableViewCell.cellIdentifier)
        let loadingNib = UINib(nibName: "LoadingTableViewCell", bundle: nil)
        tableView.register(loadingNib, forCellReuseIdentifier: LoadingTableViewCell.cellIdentifier)
        
        tableView.refreshControl = refreshControl
    }
    
    private func setupRefreshControl() {
        refreshControl.attributedTitle = NSAttributedString(string: "Looking for Reddit entries...")
        refreshControl.addTarget(self, action: #selector(refreshTopEntries(_:)), for: .valueChanged)
    }
    
    // MARK: - Actions
    
    @objc private func refreshTopEntries(_ sender: Any) {
        viewModel?.resetPagination()
        viewModel?.fetchTopEntries()
    }
}

extension RedditListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return kZeroRow }

        if section == kChildrenSection {
            return viewModel.entriesCount()
        } else if section == kLoadingSection && viewModel.isFetching {
            return kOneRow
        }
        
        return kZeroRow
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == kChildrenSection {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: RedditChildrenTableViewCell.cellIdentifier, for: indexPath) as? RedditChildrenTableViewCell else {
                return UITableViewCell()
            }
            guard let viewModel = viewModel?.viewModelForItemAt(indexPath: indexPath) else { return UITableViewCell() }
            cell.topEntryViewModel = viewModel
            cell.configure()
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: LoadingTableViewCell.cellIdentifier, for: indexPath) as? LoadingTableViewCell else {
                return UITableViewCell()
            }
            cell.loadingSign.startAnimating()
            return cell
        }
    }
}

extension RedditListViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        kNumberOfSections
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        
        if offsetY > contentHeight - scrollView.frame.height * 4 {
            viewModel?.fetchTopEntries()
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.showEntryDetailsAt(indexPath: indexPath)
    }
}

extension RedditListViewController: TopEntriesFetchingDelegate {
    func fetchSuccess() {
        self.refreshControl.endRefreshing()
        tableView.reloadData()
    }
    
    func fetchFailure() {
        let alert = UIAlertController(title: "Ops", message: "Failed fetching entries.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
