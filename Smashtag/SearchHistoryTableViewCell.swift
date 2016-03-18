//
//  SearchHistoryTableViewCell.swift
//  Smashtag
//
//  Created by Angelo Wong on 3/17/16.
//  Copyright © 2016 Stanford. All rights reserved.
//

import UIKit

class SearchHistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var searchText: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
