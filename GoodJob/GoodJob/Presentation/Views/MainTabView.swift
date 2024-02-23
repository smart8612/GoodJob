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
        
        TabView(selection: tabSelection) {
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
    
    private var tabSelection: Binding<GJAppCategory> {
        return .init {
            return navigationModel.selectedCategory
        } set: { newValue in
            if newValue == navigationModel.selectedCategory {
                navigationModel.popToRoot()
            }
            navigationModel.selectedCategory = newValue
        }

    }
    
}
