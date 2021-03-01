//
//  teamCreationViewController.swift
//  PokeTeam Maker
//
//  Created by Brandon Gonzalez on 01/03/21.
//

import UIKit
import TableViewReloadAnimation
import PokemonAPI
import Firebase

class teamCreationViewController: UIViewController {
    
    @IBOutlet weak var allPokemonTableView: UITableView!
    var pokemonInfo: [Dictionary<String, Any>] = []
    var selectedRowNumber: NSMutableArray = []
    var pokemons: [Dictionary<String, Any>] = []
    let database = Database.database().reference()
    @IBOutlet weak var teamName: UITextField!
    @IBOutlet weak var teamDescription: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getInformation()
        configureTable()
    }
    
    
    
    func getInformation() {
        self.pokemonInfo.removeAll()
        var request = URLRequest(url: URL(string: "https://pokeapi.co/api/v2/pokemon?limit=1118")!)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request, completionHandler: { data, response, error -> Void in
            let json = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
            
            if let dictionary = json as? Dictionary<String, AnyObject> {
                if let items = dictionary["results"] {
                    for d in items as! [Dictionary<String, AnyObject>] {
                        self.pokemonInfo.append(d)
                    }
                    print(self.pokemonInfo)
                }
            }
            
            DispatchQueue.main.async {
                
                if self.pokemonInfo.count > 0 {
                    self.allPokemonTableView.reloadData(with: .simple(duration: 0.75, direction:.rotation3D(type: .spiderMan),constantDelay: 0))
                }
            }
        }).resume()
    }
    
    func configureTable() {
        allPokemonTableView.delegate = self
        allPokemonTableView.dataSource = self
        allPokemonTableView.tableFooterView = UIView()
        let documentXib = UINib(nibName: "pokemonDetailTableViewCell", bundle: nil)
        allPokemonTableView.register(documentXib, forCellReuseIdentifier: pokemonDetailTableViewCell.cellIdentifier)
        allPokemonTableView.separatorStyle = .none
        allPokemonTableView.separatorColor = .white
        allPokemonTableView.allowsSelection = true
        allPokemonTableView.allowsMultipleSelection = true
    }
    
    @IBAction func addNewTeam(_ sender: Any) {
        
        if teamName.text?.isEmpty == true {
            return
        }
        
        if teamDescription.text?.isEmpty == true {
            return
        }
        
        self.database.child("TeamsDic").child("\(teamName.text!)").child("Pokemones").setValue(self.pokemons)
        
    }
    
}

extension teamCreationViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pokemonInfo.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: pokemonDetailTableViewCell.cellIdentifier, for: indexPath) as? pokemonDetailTableViewCell else {
            return UITableViewCell()
        }
        cell.prepareForReuse()
        cell.selectionStyle = .none
        let regionInfo = pokemonInfo[indexPath.row]
        let name = regionInfo["name"] as! String
        PokemonAPI().pokemonService.fetchPokemon(name) { result in
            switch result {
            case .success(let pokemon):
                let imageForPoke = pokemon.sprites?.frontDefault
                DispatchQueue.main.async {
                    cell.pokemonImage.sd_setImage(with: URL(string: imageForPoke ?? ""), completed: nil)
                    cell.pokemonName.text = pokemon.name
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        cell.accessoryType = .none
                if selectedRowNumber.contains(indexPath.row) {
                    cell.accessoryType = .checkmark
                    cell.isUserInteractionEnabled = false
                }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell: UITableViewCell = tableView.cellForRow(at: indexPath)!
        cell.accessoryType = .checkmark
        cell.isUserInteractionEnabled = false
        self.selectedRowNumber.add(indexPath.row)
        let regionInfo = pokemonInfo[indexPath.row]
        let name = regionInfo["name"] as! String
        let newPokemon = ["name":"\(name)"]
        self.pokemons.append(newPokemon)
        print(self.pokemons)
    }
    
    
}

extension teamCreationViewController: deleteATeam {
    func deleteATeam(nameOfTeam: String) {
        database.child("TeamDic").child(nameOfTeam).removeValue()
        NotificationCenter.default.post(name: Notification.Name("teamDeleted"), object: nil)
    }
}
