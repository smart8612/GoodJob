//
//  SidebarListView.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/15/24.
//

import SwiftUI


struct SidebarListView: View {
    
    @EnvironmentObject private var navigationModel: GJNavigationModel
    
    private var categories = GJAppCategory.allCategories
    
    var body: some View {
        List(
            categories,
            selection: $navigationModel.selectedCategory
        ) { category in
            NavigationLink(value: category) {
                SidebarCellView(category: category)
            }
        }
        .navigationTitle("GoodJob")
    }
    
}
