//
//  DetailView.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/22/24.
//

import SwiftUI


struct DetailView: View {
    
    @EnvironmentObject private var navigationModel: GJNavigationModel
    
    var body: some View {
        
        NavigationStack {
            switch navigationModel.selectedCategory {
            case .summary:
                Text("Select a summary item")
            case .applications:
                JobApplicationDetailView()
            case .jobs:
                JobPostingDetailView()
            case nil:
                Text("Select a category")
            }
        }
        
    }
    
}
