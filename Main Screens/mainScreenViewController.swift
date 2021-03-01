//
//  mainScreenViewController.swift
//  PokeTeam Maker
//
//  Created by Brandon Gonzalez on 27/02/21.
//

import UIKit
import PokemonAPI
import TableViewReloadAnimation
import Firebase

class mainScreenViewController: UIViewController {
    
    //MARK: Outlets
    
    var regions: [Dictionary<String, Any>] = []
    let reuseDocument = "DocumentCell"
    private let database = Database.database().reference()
    
    @IBOutlet weak var toolBarView: UIView!
    @IBOutlet weak var topLogo: UIImageView!
    @IBOutlet weak var regionsTableView: UITableView!
    
    //MARK: viewDid Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getInformation()
        setupView()
        configureTable()
    }
    
    //MARK: Funcs
    
    func setupView() {
        // Shadow Color and Radius
        toolBarView.layer.shadowColor = UIColor.gray.cgColor
        toolBarView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        toolBarView.layer.shadowOpacity = 1.0
        toolBarView.layer.shadowRadius = 0.0
        toolBarView.layer.masksToBounds = false
        toolBarView.layer.cornerRadius = 0
    }
    
    func configureTable() {
        regionsTableView.delegate = self
        regionsTableView.dataSource = self
        regionsTableView.tableFooterView = UIView()
        let documentXib = UINib(nibName: "regionsTableViewCell", bundle: nil)
        regionsTableView.register(documentXib, forCellReuseIdentifier: regionsTableViewCell.cellIdentifier)
        regionsTableView.separatorStyle = .none
        regionsTableView.separatorColor = .white
    }
    
    func getInformation() {
        var request = URLRequest(url: URL(string: "https://pokeapi.co/api/v2/region")!)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request, completionHandler: { data, response, error -> Void in
            let json = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
            
            if let dictionary = json as? Dictionary<String, AnyObject> {
                
                if let items = dictionary["results"] {
                    for d in items as! [Dictionary<String, AnyObject>] {
                        self.regions.append(d)
                    }
                }
            }
            DispatchQueue.main.async {
                
                if self.regions.count > 0 {
                    self.regionsTableView.reloadData(
                        with: .simple(duration: 0.75, direction: .rotation3D(type: .daredevil),
                                      constantDelay: 0))
                    self.database.child("RegionsDic").setValue(self.regions)
                }
            }
        }).resume()
    }
    
    func regionImage(regionName:String) -> String {
        switch regionName {
        case "kanto":
            return "kantoArt"
        case "johto":
            return "johtoArt"
        case "hoenn":
            return "hoennArt"
        case "sinnoh":
            return "sinnohArt"
        case "unova":
            return "unovaArt"
        case "kalos":
            return "kalosArt"
        case "alola":
            return "alolaArt"
        case "galar":
            return "galarArt"
        default:
            return ""
        }
    }
    
    func getPokedex(regionName:String) -> String {
        switch regionName {
        case "kanto":
            return "https://pokeapi.co/api/v2/pokedex/26/"
        case "johto":
            return "https://pokeapi.co/api/v2/pokedex/7/"
        case "hoenn":
            return "https://pokeapi.co/api/v2/pokedex/15/"
        case "sinnoh":
            return "https://pokeapi.co/api/v2/pokedex/6/"
        case "unova":
            return "https://pokeapi.co/api/v2/pokedex/9/"
        case "kalos":
            return "https://pokeapi.co/api/v2/pokedex/12/"
        case "alola":
            return "https://pokeapi.co/api/v2/pokedex/21/"
        case "galar":
            return "https://pokeapi.co/api/v2/pokedex/27/"
        default:
            return ""
        }
    }
    
    //MARK: Buttons
    
    @IBAction func openTeamsView(_ sender: Any) {
        let teamsVC = myTeamsViewController(nibName: "myTeamsViewController", bundle: nil)
        self.present(teamsVC, animated: true, completion: nil)
    }
    
}

extension mainScreenViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        regions.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: regionsTableViewCell.cellIdentifier, for: indexPath) as? regionsTableViewCell else {
            return UITableViewCell()
        }
        let regionInfo = regions[indexPath.row]
        let name = regionInfo["name"] as? String
        cell.nameLabel.text = name!
        cell.regionImage.image = UIImage(named: regionImage(regionName: name!))
        cell.nameLabel.font = UIFont(name:"PokemonSolidNormal", size:45)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = regionDetailPokemonViewController(nibName: "regionDetailPokemonViewController", bundle: nil)
        let regionInfo = regions[indexPath.row]
        let name = regionInfo["name"] as? String
        detailVC.regionNameInfo = name ?? "Región"
        detailVC.pokedex = getPokedex(regionName: name ?? "Región")
        self.present(detailVC, animated: true, completion: nil)
    }
}
