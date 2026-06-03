//
//  MPGitUserShowCaseApp.swift
//  MPGitUserShowCase
//
//  Created by Manish Parihar on 20.05.26.
//

import SwiftUI
import SwiftData

enum CurrentScreen {
    case gitUser, favourite
}

@main
struct MPGitUserShowCaseApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    @State private var themeManager = ThemeManager()
    @State private var currentScreen: CurrentScreen = .gitUser


    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            switch currentScreen {
            case .gitUser:
                //ContentView()
                //    .environment(themeManager)
                // UserScreen(navigator: <#TabNavigator#>)
                MainScreen()
            case .favourite:
                EmptyView()
            }
        }
        //.modelContainer(sharedModelContainer)
    }
}

class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        #if DEBUG
        print("👷🏾‍♂️ Is UI Test Running: \(UITestingHelper.isUITesting)")
        #endif
        return true
    }
}
