//
//  welcomeScreenViewController.swift
//  PokeTeam Maker
//
//  Created by Brandon Gonzalez on 28/02/21.
//

import UIKit
import Hero

class welcomeScreenViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.hero.isEnabled = true
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "mainScreenViewController") as! mainScreenViewController
            newViewController.hero.modalAnimationType = .fade
            self.hero.replaceViewController(with: newViewController)
        }
    }
    
}
