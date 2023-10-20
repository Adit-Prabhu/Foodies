//
//  FoodiesApp.swift
//  Foodies
//
//  Created by Adit Prabhu on 3/14/23.
//

import SwiftUI

@main
struct FoodiesApp: App {
    //let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            //ContentView()
            //    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            StartScreen()
        }
    }
}
