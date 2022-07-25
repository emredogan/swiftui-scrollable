//
//  AppDelegate.swift
//  SwiftUI_ScrollableList
//
//  Created by Emre Dogan on 25/07/2022.
//

import Foundation
import FirebaseCore
import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
