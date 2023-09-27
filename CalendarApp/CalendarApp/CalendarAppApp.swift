//
//  CalendarAppApp.swift
//  CalendarApp
//
//  Created by Mohamed Elatabany on 28/09/2023.
//

import SwiftUI

@main
struct CalendarAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
