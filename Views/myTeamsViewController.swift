//
//  myTeamsViewController.swift
//  PokeTeam Maker
//
//  Created by Brandon Gonzalez on 01/03/21.
//

import UIKit
import Firebase

class myTeamsViewController: UIViewController {
    
    // MARK: Outlets
    
    private let database = Database.database().reference()
    var teams: [Dictionary<String, Any>] = []
    @IBOutlet weak var teamsTableView: UITableView!
    
    // MARK: viewDid
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTable()
        getTeams()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        // This is reloading the data on the tableview after feeding it from the database. Must be fixed.
        DispatchQueue.main.async {
            
            if self.teams.count > 0 {
                print("called")
                self.teamsTableView.reloadData()
            } else {
                self.teamsTableView.setEmptyView(title: "Aún no tienes equipos.", message: "Puedes crear uno con el boton de arriba a la derecha. ⚡️")
            }
        }
    }
    
    // MARK: Funcs
    
    // Loading the tableview
    func configureTable() {
        teamsTableView.delegate = self
        teamsTableView.dataSource = self
        teamsTableView.tableFooterView = UIView()
        let documentXib = UINib(nibName: "teamCellTableViewCell", bundle: nil)
        teamsTableView.register(documentXib, forCellReuseIdentifier: teamCellTableViewCell.cellIdentifier)
        teamsTableView.separatorStyle = .none
        teamsTableView.separatorColor = .white
    }
    
    // This is the source for the tableview information
    func getTeams() {
        database.child("TeamsDic").observeSingleEvent(of: .value, with: { snapshot in
            let realvalue = snapshot.value
            print(realvalue)
            guard let value = snapshot.value as? Dictionary<String, Any> else {
                print("No teams")
                return
            }
            self.teams.append(value)
        })
    }
    
    // MARK: Buttons
    
    // Takes the user to another view.
    @IBAction func addTeam(_ sender: Any) {
        let teamCreationVC = teamCreationViewController(nibName: "teamCreationViewController", bundle: nil)
        self.present(teamCreationVC, animated: true, completion: nil)
    }
    
    // Closes the current view.
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

// MARK: Extensions

extension myTeamsViewController: UITableViewDelegate, UITableViewDataSource {
    
    // Tableview Information
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        teams.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: teamCellTableViewCell.cellIdentifier, for: indexPath) as? teamCellTableViewCell else {
            return UITableViewCell()
        }
        let dictKeys = Array(teams)
        cell.titleText.text = "\(dictKeys[indexPath.row].keys)"
        return cell
    }
}
