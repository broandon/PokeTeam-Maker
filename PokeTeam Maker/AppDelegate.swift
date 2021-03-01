//
//  AppDelegate.swift
//  PokeTeam Maker
//
//  Created by Brandon Gonzalez on 27/02/21.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window:UIWindow?
    
    override init() {
        super.init()
        UIFont.overrideInitialize()
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FontBlaster.blast()
        FirebaseApp.configure()
        return true
    }

}
