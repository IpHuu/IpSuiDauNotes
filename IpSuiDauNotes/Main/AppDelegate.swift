//
//  AppDelegate.swift
//  IpSuiDauNotes
//
//  Created by Ipman on 16/08/2023.
//

import Foundation
import SwiftUI
import Firebase
class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
      FirebaseApp.configure()
    return true
  }
}
