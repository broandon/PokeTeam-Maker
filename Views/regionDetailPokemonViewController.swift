//
//  regionDetailPokemonViewController.swift
//  PokeTeam Maker
//
//  Created by Brandon Gonzalez on 01/03/21.
//

import UIKit
import PokemonAPI
import SDWebImage

class regionDetailPokemonViewController: UIViewController {
    
    //MARK: Outlets
    
    var pokemonInfo: [Dictionary<String, Any>] = []
    var regionNameInfo:String = ""
    var pokedex:String = ""
    @IBOutlet weak var regionName: UILabel!
    @IBOutlet weak var pokedexTableView: UITableView!
    
    //MARK: viewDid
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getInformation()
        configureTable()
    }
    
    //MARK: Funcs
    
    func configureTable() {
        pokedexTableView.delegate = self
        pokedexTableView.dataSource = self
        pokedexTableView.tableFooterView = UIView()
        let documentXib = UINib(nibName: "pokemonDetailTableViewCell", bundle: nil)
        pokedexTableView.register(documentXib, forCellReuseIdentifier: pokemonDetailTableViewCell.cellIdentifier)
        pokedexTableView.separatorStyle = .none
        pokedexTableView.separatorColor = .white
        pokedexTableView.allowsSelection = false
    }
    
    
    func getInformation() {
        self.pokemonInfo.removeAll()
        var request = URLRequest(url: URL(string:pokedex)!)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request, completionHandler: { data, response, error -> Void in
            let json = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
            
            if let dictionary = json as? Dictionary<String, AnyObject> {
                
                if let items = dictionary["pokemon_entries"] {
                    for d in items as! [Dictionary<String, AnyObject>] {
                        self.pokemonInfo.append(d)
                    }
                }
            }
            
            DispatchQueue.main.async {
                
                if self.pokemonInfo.count > 0 {
                    self.pokedexTableView.reloadData(with: .simple(duration: 0.75, direction:.rotation3D(type: .spiderMan),constantDelay: 0))
                }
            }
        }).resume()
    }
    
    func setupView() {
        self.regionName.text = regionNameInfo
    }
    
    //MARK: Buttons
    
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension regionDetailPokemonViewController: UITableViewDelegate, UITableViewDataSource {
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
        let regionInfo = pokemonInfo[indexPath.row]
        let species = regionInfo["pokemon_species"] as! [String:String]
        let name = species["name"]
        PokemonAPI().pokemonService.fetchPokemon(name!) { result in
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
        return cell
        
    }
    
}
