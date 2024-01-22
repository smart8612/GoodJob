//
//  MainTabView.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/22/24.
//

import SwiftUI

final class GJNavigationModel: ObservableObject {
    
    @Published var selectedCategory: GJAppCategory = .summary
        
}


struct MainTabView: View {
    
    @StateObject private var navigationModel = GJNavigationModel()
    
    private let categories = GJAppCategory.allCategories
    
    var body: some View {
        
        TabView(selection: $navigationModel.selectedCategory) {
            ForEach(categories) { category in
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
