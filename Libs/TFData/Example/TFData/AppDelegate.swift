//
//  AppDelegate.swift
//  TFData
//
//  Created by Guillermo Sáenz on 12/11/2020.
//  Copyright (c) 2020 Guillermo Sáenz. All rights reserved.
//

import UIKit

import PromiseKit
import TFData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    let api = TransformersDataRemoteAPI()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let transformersDataRemoteAPI = TransformersDataRemoteAPI()
        let dataRepository = TransformersDataRepository(transformersDataRemoteAPI: transformersDataRemoteAPI)
        
        let request = TransformerRequest(name: "942v",
                                         strength: 1,
                                         intelligence: 1,
                                         speed: 1,
                                         endurance: 1,
                                         rank: 1,
                                         courage: 1,
                                         firepower: 1,
                                         skill: 1,
                                         team: .autobot)
        
        dataRepository.create(request).done { createdTransformer in
            let transformer = TransformerRequest(id: createdTransformer.id,
                                                 name: "942v2",
                                                 strength: createdTransformer.strength,
                                                 intelligence: createdTransformer.intelligence,
                                                 speed: createdTransformer.speed,
                                                 endurance: createdTransformer.endurance,
                                                 rank: createdTransformer.rank,
                                                 courage: createdTransformer.courage,
                                                 firepower: createdTransformer.firepower,
                                                 skill: createdTransformer.skill,
                                                 team: createdTransformer.team)
            
            firstly {
                dataRepository.change(transformer)
            }.then { _ in
                dataRepository.getTransformers()
            }.done { list in
                print("Finish! \(list)")
            }.catch {
                guard let error = $0 as? RemoteAPIError else {
                    return
                }
                print("Error: \(error.description)")
            }
        }.catch {
            guard let error = $0 as? RemoteAPIError else {
                return
            }
            print("Error: \(error.description)")
        }
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

