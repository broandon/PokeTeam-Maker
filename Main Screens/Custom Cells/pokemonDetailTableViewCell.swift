//
//  pokemonDetailTableViewCell.swift
//  PokeTeam Maker
//
//  Created by Brandon Gonzalez on 01/03/21.
//

import UIKit

class pokemonDetailTableViewCell: UITableViewCell {
    
    static let cellIdentifier = "pokemonDetailTableViewCell"
    
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var redColorBackground: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupView()
    }
    
    override func prepareForReuse() {
        pokemonImage.image = nil
        pokemonName.text = ""
    }
    
    func setupView() {
        redColorBackground.layer.cornerRadius = 14
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }    
}
