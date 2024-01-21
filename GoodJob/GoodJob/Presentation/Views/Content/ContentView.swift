//
//  ContentView.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/15/24.
//

import SwiftUI


struct ContentView: View {
    
    @EnvironmentObject private var navigationModel: GJNavigationModel
    
    private var navigationTitle: String {
        navigationModel.selectedCategory?.name ?? ""
    }
    
    private var selectedCategory: GJAppCategory? {
        navigationModel.selectedCategory
    }
    
    var body: some View {
        ZStack {
            switch selectedCategory {
            
            case .summary:
                SummaryView()
                
            case .applications:
                JobApplicationsListView()
            
            case .jobs:
                JobPostingsListView()
                
            case .none:
                Text("Select a category")
            }
            
        }
        .navigationTitle(navigationTitle)
    }
    
}
