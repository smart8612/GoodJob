//
//  SidebarCellView.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/15/24.
//

import SwiftUI


struct SidebarCellView: View {
    
    let category: Category
    
    var body: some View {
        HStack {
            Image(systemName: category.symboleName)
                .resizable()
                .scaledToFit()
                .frame(width: 15, height: 15)
            Text(category.name)
        }
    }
    
}
