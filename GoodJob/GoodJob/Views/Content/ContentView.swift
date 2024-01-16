//
//  ContentView.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/15/24.
//

import SwiftUI


struct ContentView: View {
    
    @Binding var selectedCategory: Category?
    
    var body: some View {
        Group {
            switch selectedCategory {
            
            case .summary:
                SummaryView()
            
            case .jobs:
                JobPostingsListView()
                
            
            case .none:
                Text("Select a category")
                
            default:
                Text("Hello, World!")
                
            }
        }
        .navigationTitle(selectedCategory?.name ?? "")
    }
    
}
