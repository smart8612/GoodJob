//
//  SidebarCellView.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/15/24.
//

import SwiftUI


struct SidebarCellView: View {
    
    let category: GJAppCategory
    
    var body: some View {
        Label(category.name,systemImage: category.symboleName)
    }
    
}
