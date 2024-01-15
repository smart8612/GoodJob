//
//  GoodJobApp.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/15/24.
//

import SwiftUI

@main
struct GoodJobApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MainSplitView()
                .environment(\.managedObjectContext,
                              persistenceController.managedObjectContext)
        }
    }
}
