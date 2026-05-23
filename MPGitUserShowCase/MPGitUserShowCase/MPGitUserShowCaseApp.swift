//
//  MPGitUserShowCaseApp.swift
//  MPGitUserShowCase
//
//  Created by Manish Parihar on 20.05.26.
//

import SwiftUI
import SwiftData

@main
struct MPGitUserShowCaseApp: App {
    @State private var themeManager = ThemeManager()

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
            ContentView()
                .environment(themeManager)
        }
        .modelContainer(sharedModelContainer)
    }
}
