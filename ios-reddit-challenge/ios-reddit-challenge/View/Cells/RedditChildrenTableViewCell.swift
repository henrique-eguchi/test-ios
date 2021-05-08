//
//  RedditChildrenTableViewCell.swift
//  ios-reddit-challenge
//
//  Created by Henrique Akiyoshi Eguchi on 05/05/21.
//

import UIKit

class RedditChildrenTableViewCell: UITableViewCell {

    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var createdLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var commentCountLabel: UILabel!
    @IBOutlet weak var thumbnailImageViewHeightConstraint: NSLayoutConstraint!

    static let cellIdentifier = "RedditChildrenItemCell"
    
    var topEntryViewModel: TopEntryCellViewModel?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configure() {
        guard let topEntryViewModel = topEntryViewModel else { return }
        
        authorLabel.text = topEntryViewModel.author
        createdLabel.text = topEntryViewModel.entryDate
        titleLabel.text = topEntryViewModel.title
        commentCountLabel.text = "💬 \(topEntryViewModel.commentsCount)"
        
        if let thumbnailImageURL = topEntryViewModel.thumbnail {
            thumbnailImageView.imageFromURL(thumbnailImageURL)
        }
    }
    
}
