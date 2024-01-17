//
//  SidebarListView.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/15/24.
//

import SwiftUI


struct SidebarListView: View {
    
    @Binding var selectedCategory: Category?
    
    var body: some View {
        List(Category.allCategories, selection: $selectedCategory) { category in
            SidebarCellView(category: category)
                .tag(category)
        }
        .navigationTitle("GoodJob")
    }
    
}