//
//  LoadingTableViewCell.swift
//  ios-reddit-challenge
//
//  Created by Henrique Akiyoshi Eguchi on 06/05/21.
//

import UIKit

class LoadingTableViewCell: UITableViewCell {

    @IBOutlet weak var loadingSign: UIActivityIndicatorView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
