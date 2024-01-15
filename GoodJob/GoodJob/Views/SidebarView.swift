//
//  SidebarView.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/15/24.
//

import SwiftUI


struct SidebarView: View {
    
    var categories: [Category]
    @Binding var selectedCategory: Category?
    
    var body: some View {
        List(categories, selection: $selectedCategory) { category in
            HStack {
                Image(systemName: category.symboleName)
                Text(category.name)
            }.tag(category)
        }
        .navigationTitle("GoodJob")
    }
    
}
