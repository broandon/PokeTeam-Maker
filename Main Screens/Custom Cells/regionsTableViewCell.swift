//
//  regionsTableViewCell.swift
//  PokeTeam Maker
//
//  Created by Brandon Gonzalez on 28/02/21.
//

import UIKit

class regionsTableViewCell: UITableViewCell {
    
    static let cellIdentifier = "regionsTableViewCell"

    @IBOutlet weak var whiteBackground: UIView!
    @IBOutlet weak var regionImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupEffects()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupEffects() {
        whiteBackground.layer.cornerRadius = 14
        regionImage.layer.cornerRadius = 14
    }
}
