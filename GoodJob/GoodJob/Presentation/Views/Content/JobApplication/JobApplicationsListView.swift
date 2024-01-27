//
//  JobApplicationsListView.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/20/24.
//

import SwiftUI


struct JobApplicationsListView: View {
    
    @StateObject private var model = GJJobApplicationViewModel()
    @EnvironmentObject private var navigationModel: GJNavigationModel
    
    var body: some View {
        
        NavigationStack {
            DataContainer {
                List {
                    ForEach(model.jobApplications) { jobApplication in
                        NavigationLink(value: jobApplication) {
                            JobApplicationCellView(
                                jobApplication: jobApplication
                            )
                        }
                    }
                }
                .navigationDestination(for: GJJobApplication.self) {
                    JobApplicationDetailView(model: .init(
                        selectedJobApplicationId: $0.id
                    ))
                }
            } sheet: { isShowingSheet in
                NewJobApplicaitonView(isShowingSheet: isShowingSheet)
            }
            .navigationTitle(navigationModel.selectedCategory.name)
        }
        
    }
    
}


fileprivate struct JobApplicationCellView: View {
    
    let jobApplication: GJJobApplication
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(jobApplication.title)
                .font(.headline)
            Text(jobApplication.id.uuidString)
                .font(.caption)
        }
    }
}

