//
//  teamCellTableViewCell.swift
//  PokeTeam Maker
//
//  Created by Brandon Gonzalez on 01/03/21.
//

import UIKit

class teamCellTableViewCell: UITableViewCell {
    
    static let cellIdentifier = "teamCellTableViewCell"

    @IBOutlet weak var titleText: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
