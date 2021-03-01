//
//  myTeamsViewController.swift
//  PokeTeam Maker
//
//  Created by Brandon Gonzalez on 01/03/21.
//

import UIKit
import Firebase

class myTeamsViewController: UIViewController {
    
    private let database = Database.database().reference()
    var teams: [Dictionary<String, Any>] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getTeams()
    }
    
    func getTeams() {
        database.child("TeamsDic").observeSingleEvent(of: .value, with: { snapshot in
            guard let value = snapshot.value as? Dictionary<String, Any> else {
                print("No teams")
                return
            }
            self.teams.append(value)
            print(self.teams)
        })
    }
    
    @IBAction func addTeam(_ sender: Any) {
        let viewController:UIViewController = UIStoryboard(name: "popUps", bundle: nil).instantiateViewController(withIdentifier: "addTeamPopUpViewController") as! addTeamPopUpViewController
        self.present(viewController, animated: false, completion: nil)
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
