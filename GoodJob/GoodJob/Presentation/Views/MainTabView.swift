//
//  MainTabView.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/22/24.
//

import SwiftUI


struct MainTabView: View {
    
    @StateObject private var navigationModel = GJNavigationModel()
    
    var body: some View {
        
        TabView(selection: navigationModel.tabSelection) {
            ForEach(navigationModel.categories) { category in
                category.contentView
                    .tabItem {
                        Label(
                            category.name,
                            systemImage: category.symboleName
                        )
                    }
                    .tag(category)
            }
        }
        .environmentObject(navigationModel)
        
    }
    
}
