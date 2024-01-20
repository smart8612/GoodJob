//
//  ContentView.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/15/24.
//

import SwiftUI


struct ContentView: View {
    
    @Binding var selectedCategory: GJAppCategory?
    
    var body: some View {
        Group {
            switch selectedCategory {
            
            case .summary:
                SummaryView()
                
            case .applications:
                JobApplicationView()
            
            case .jobs:
                JobPostingsListView()
                
            case .none:
                Text("Select a category")
            }
        }
        .navigationTitle(selectedCategory?.name ?? "")
    }
    
}
