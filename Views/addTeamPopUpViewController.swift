//
//  addTeamPopUpViewController.swift
//  PokeTeam Maker
//
//  Created by Brandon Gonzalez on 01/03/21.
//

import UIKit
import Firebase

class addTeamPopUpViewController: UIViewController {

    private let database = Database.database().reference()
    @IBOutlet weak var popUpBackground: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var addPokemonButton: UIButton!
    @IBOutlet weak var teamName: UITextField!
    @IBOutlet weak var teamDescription: UITextField!
    var teams: [Dictionary<String, Any>] = []
    var newTeam: Dictionary<String, Any> = ["name": "NewTeam", "description": "Some description", "Pokemons": ["name":"bulbausur"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    func setupView() {
        popUpBackground.layer.cornerRadius = 14
        popUpBackground.layer.masksToBounds = true
        addPokemonButton.layer.cornerRadius = 14
    }
    
    @IBAction func addTeam(_ sender: Any) {
        if teamName.text?.isEmpty == true {
        return
        }
        if teamDescription.text?.isEmpty == true {
            return
        }
        let creatingTeam = ["name": "\(teamName.text!)", "description": "\(teamDescription.text!)", "Pokemons":[]] as [String : Any]
        self.teams.append(creatingTeam)
        self.database.child("TeamsDic").setValue(self.teams)
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
//            let newPokemons = [["name":"bulbausaur", "Ability":"Fire", "Weight":"123"], ["name":"bulbausaur", "Ability":"Fire", "Weight":"123"], ["name":"bulbausaur", "Ability":"Fire", "Weight":"123"]]
//            self.database.child("TeamsDic").child("Titanes").child("Pokemones").setValue(newPokemons)
//        }
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 6.5) {
//
//            self.database.child("TeamsDic").child("Titanes").child("Pokemones").observeSingleEvent(of: .value, with: { snapshot in
//                guard let value = snapshot.value as? [Dictionary<String, Any>] else {
//                    print("No teams")
//                    return
//                }
//
//                print(value)
//                var oldview = value as? [Dictionary<String,Any>]
//                let newPokemon = ["name":"bulbausaur", "Ability":"Fire", "Weight":"123"]
//                oldview?.append(newPokemon)
//                self.database.child("TeamsDic").child("Titanes").child("Pokemones").setValue(oldview)
//
//            })
//
//
//        }

    }
    
    @IBAction func closeView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
