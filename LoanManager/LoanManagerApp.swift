//
//  LoanManagerApp.swift
//  LoanManager
//
//  Created by Home on 5/7/21.
//

import SwiftUI

@main
struct LoanManagerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
