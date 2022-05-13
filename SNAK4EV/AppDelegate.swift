//
//  AppDelegate.swift
//  SNAK4EV
//
//  Created by Apple  on 30/03/22.
//

import UIKit
import Firebase
import IQKeyboardManagerSwift
import GoogleMaps
import GooglePlaces

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    final var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let _ = LocationManager.shared
        // Override point for customization after application launch.
        FirebaseApp.configure()
        IQKeyboardManager.shared.enable = true
        GMSServices.provideAPIKey(googleProvideAPIKey)
        GMSServices.openSourceLicenseInfo()
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.makeKeyAndVisible()
        self.setRootVC()
        return true
    }
    
    
}

extension AppDelegate{
    func setRootVC(){
        let isValidUser = UserDefaults.standard.object(forKey: "customerid") != nil ? true : false
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let navigationController:UINavigationController = storyboard.instantiateInitialViewController() as! UINavigationController
        if(Connectivity.isConnectedToInternet){
            if isValidUser{
                Globals.shared.customerId = UserDefaults.standard.object(forKey: "customerid") as? String ?? ""
                let rootViewController:UIViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                navigationController.viewControllers = [rootViewController]
            }else{
                let rootViewController:UIViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                navigationController.viewControllers = [rootViewController]
            }
        }else{
            let rootViewController:UIViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            navigationController.viewControllers = [rootViewController]
        }
        self.window?.rootViewController = navigationController
    }
}

