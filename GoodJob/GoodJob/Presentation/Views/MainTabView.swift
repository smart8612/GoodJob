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
        
        TabView {
            ForEach(GJAppCategory.allCases) { category in
                category.contentView
                    .tabItem {
                        Label(
                            category.name,
                            systemImage: category.symboleName
                        )
                    }
            }
        }
        .environmentObject(navigationModel)
        
    }
    
}

#Preview {
    MainTabView()
}
