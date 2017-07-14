//
//  AppDelegate.swift
//  Foodie
//
//  Created by Eduardo Pacheco on 12/04/17.
//  Copyright © 2017 Eduardo Pacheco. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        setupUI()
        if !(UserDefaults.standard.bool(forKey: "hasViewedWalkthrough")) {
            let sb = UIStoryboard(name: "Walkthrough", bundle: nil)
            guard let pageViewController = sb.instantiateInitialViewController() as? WalkthroughPageVC else { return true }
            window?.rootViewController!.present(pageViewController, animated: true, completion: nil)
        }
        return true
    }

    // MARK: - Private Methods
    private func setupUI() {
        UIApplication.shared.statusBarStyle = .default
        UINavigationBar.appearance().barTintColor = UIColor(red: 216/255, green: 74/255, blue: 32/255, alpha: 1.0)
        UINavigationBar.appearance().tintColor = .black
        if let barFont = UIFont(name: "AvenirNextCondensed-DemiBold", size: 24.0) {
            UINavigationBar.appearance().titleTextAttributes = [
                NSAttributedStringKey.foregroundColor.rawValue: UIColor.black,
                NSAttributedStringKey.font.rawValue: barFont
            ]
        }
    }

    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Foodie")
        container.loadPersistentStores(completionHandler: { (storeDesc, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
