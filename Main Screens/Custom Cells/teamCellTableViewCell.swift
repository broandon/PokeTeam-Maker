//
//  teamCellTableViewCell.swift
//  PokeTeam Maker
//
//  Created by Brandon Gonzalez on 01/03/21.
//

import UIKit

protocol deleteATeam {
    func deleteATeam(nameOfTeam:String)
}

class teamCellTableViewCell: UITableViewCell {
    
    static let cellIdentifier = "teamCellTableViewCell"

    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var pokemonQUa: UILabel!
    var delegate: deleteATeam!
    var teamName:String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print(teamName)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func deleteTheTeam(_ sender: Any) {
        self.delegate.deleteATeam(nameOfTeam: teamName)
    }
}
