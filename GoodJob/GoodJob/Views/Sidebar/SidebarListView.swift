//
//  SidebarListView.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/15/24.
//

import SwiftUI


struct SidebarListView: View {
    
    var categories: [Category]
    @Binding var selectedCategory: Category?
    
    var body: some View {
        List(categories, selection: $selectedCategory) { category in
            SidebarCellView(category: category)
                .tag(category)
        }
        .navigationTitle("GoodJob")
    }
    
}
