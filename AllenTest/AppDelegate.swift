//
//  AppDelegate.swift
//  AllenTest
//
//  Created by Vijay Singh Raghav on 19/03/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        launchApp()
        return true
    }
    
    func launchApp() {
        window = UIWindow(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        let sb = UIStoryboard(name: "Main", bundle: .main)
        if let vc = sb.instantiateViewController(withIdentifier: "SplitHomeVC") as? SplitHomeVC {            
            let navVC = UINavigationController(rootViewController: vc)
            window?.rootViewController = navVC
            window?.makeKeyAndVisible()            
        }
    }
}

