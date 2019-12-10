//
//  AppDelegate.swift
//  SimpleSwiftNumericKeyboard
//
//  Created by mmachado53 on 12/05/2019.
//  Copyright (c) 2019 mmachado53. All rights reserved.
//

import UIKit
import SimpleSwiftNumericKeyboard

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        /*
         Configure global style for SimpleSwiftNumericKeyboard
         NumericKeyBoard.GLOBAL_COLOR_PALETTE is a [NumericKeyBoardColorPaletteProp : UIColor]
         */
        
        // Color of background
        NumericKeyBoard.GLOBAL_COLOR_PALETTE[.backgroundColor] = UIColor.black
        
        // Color of numbers buttons
        NumericKeyBoard.GLOBAL_COLOR_PALETTE[.stateNormalNumberButton] = UIColor.black
        
        // Color of number buttons when is pressed
        NumericKeyBoard.GLOBAL_COLOR_PALETTE[.statePressNumerButton] = UIColor.white.withAlphaComponent(0.3)
        
        // Color of text in numbers buttons
        NumericKeyBoard.GLOBAL_COLOR_PALETTE[.textColorNumberButton] = UIColor.white
        
        // Color of secondary buttons
        NumericKeyBoard.GLOBAL_COLOR_PALETTE[.stateNormalSecondaryButton] = UIColor(red: 0.18, green: 0.18, blue: 0.18, alpha: 1)
        
        // Color of secondary buttons when is pressed
        NumericKeyBoard.GLOBAL_COLOR_PALETTE[.statePressSecondaryButton] = UIColor.white.withAlphaComponent(0.3)
        
        // Color of text in secondary buttons
        NumericKeyBoard.GLOBAL_COLOR_PALETTE[.textColorSecondaryButton] = UIColor.white
        
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

