//
//  GoodJobApp.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/15/24.
//

import SwiftUI


@main
struct GoodJobApp: App {
    
    @StateObject private var model = GJAppController()

    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environmentObject(model)
        }
    }
    
}
