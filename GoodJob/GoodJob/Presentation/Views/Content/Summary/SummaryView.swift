//
//  SummaryView.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/16/24.
//

import SwiftUI


struct SummaryView: View {
    
    @EnvironmentObject private var navigationModel: GJNavigationModel
    
    var body: some View {
        
        NavigationStack {
            Text("This is Summary View")
                .navigationTitle(navigationModel.selectedCategory.name)
            
        }
    }
    
}
