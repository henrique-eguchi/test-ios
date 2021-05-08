//
//  RedditChildrenTableViewCell.swift
//  ios-reddit-challenge
//
//  Created by Henrique Akiyoshi Eguchi on 05/05/21.
//

import UIKit
import Kingfisher

class RedditChildrenTableViewCell: UITableViewCell {

    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var createdLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var commentCountLabel: UILabel!
    @IBOutlet weak var thumbnailImageViewHeightConstraint: NSLayoutConstraint!

    static let cellIdentifier = "RedditChildrenItemCell"
    
    var topEntryViewModel: TopEntryCellViewModel?

    let kZeroHeight: CGFloat = 0
    
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
            
        thumbnailImageView.kf.setImage(with: topEntryViewModel.thumbnail) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let retrieveImageResult):
                let imageSize = retrieveImageResult.image.size
                self.thumbnailImageViewHeightConstraint.constant = imageSize.height
            case .failure(_):
                self.thumbnailImageViewHeightConstraint.constant = self.kZeroHeight
            }
        }
        commentCountLabel.text = "💬 \(topEntryViewModel.commentsCount)"
    }
    
}
