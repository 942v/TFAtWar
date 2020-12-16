//
//  AppDelegate.swift
//  TFAtWar
//
//  Created by Guillermo Sáenz on 12/11/20.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    private let appDependenciesContainer = AppDependenciesContainer()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let mainViewController = appDependenciesContainer.makeMainViewController()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = mainViewController
        
        return true
    }
}

