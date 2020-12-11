//
//  StudyLevel_App.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/11/15.
//

import SwiftUI
import Firebase
import PartialSheet

@main
struct StudyLevel_App: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    let sheetManager: PartialSheetManager = PartialSheetManager()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(sheetManager)
        }
    }
}

class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

extension Color {
    static let backgroundGray = Color("backgroundGray")
}
