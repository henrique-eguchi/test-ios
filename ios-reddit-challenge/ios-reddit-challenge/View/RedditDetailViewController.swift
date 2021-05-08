//
//  RedditDetailViewController.swift
//  ios-reddit-challenge
//
//  Created by Henrique Akiyoshi Eguchi on 05/05/21.
//

import UIKit

class RedditDetailViewController: UIViewController, Storyboarded {

    @IBOutlet weak var upLabel: UILabel!
    @IBOutlet weak var upVoteRatioLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!

    var viewModel: RedditDetailViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupDetailFields()
    }
    
    private func setupDetailFields() {
        guard let viewModel = viewModel else { return }

        if let thumbnailImageURL = viewModel.redditChildren.thumbnail {
            thumbnailImageView.imageFromURL(thumbnailImageURL)
        }
        
        upLabel.text = "⬆️ \(viewModel.redditChildren.ups.formatUsingAbbrevation())"
        upVoteRatioLabel.text = "\(Int(round(viewModel.redditChildren.upVoteRatio * 100)))% Upvoted"
    }
}
