//
//  JobApplicationView.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/20/24.
//

import SwiftUI


struct JobApplicationView: View {
    
    @StateObject private var model = GJJobApplicationViewModel()
    @EnvironmentObject private var navigationModel: GJNavigationModel
    
    var body: some View {
        
        NavigationStack(path: $navigationModel.jobApplicationPath) {
            DataContainer {
                if model.jobApplications.isEmpty {
                    Text("Empty Job Application")
                        .foregroundStyle(.secondary)
                } else {
                    JobApplicationListView()
                }
            } sheet: { isShowingSheet in
                NewJobApplicaitonView(isShowingSheet: isShowingSheet)
            }
            .navigationTitle(navigationModel.selectedCategory.name)
            .environmentObject(model)
            .onAppear { model.fetchJobApplication() }
        }
        
    }
    
}


fileprivate struct JobApplicationListView: View {
    
    @EnvironmentObject private var model: GJJobApplicationViewModel
    
    var body: some View {
        
        List {
            ForEach(model.jobApplications) { jobApplication in
                NavigationLink(value: jobApplication) {
                    JobApplicationCellView(
                        jobApplication: jobApplication
                    )
                }
            }
            .onDelete(perform: model.deleteJobApplication)
        }
        .navigationDestination(for: GJJobApplication.self) {
            JobApplicationDetailView(model: .init(
                selectedJobApplicationId: $0.id
            ))
        }
        
    }
    
}


fileprivate struct JobApplicationCellView: View {
    
    @EnvironmentObject private var model: GJJobApplicationViewModel
    
    let jobApplication: GJJobApplication
    @State private var jobPosting: GJJobPosting? = nil
    
    var body: some View {
        
        Group {
            if let jobPosting = jobPosting {
                VStack(alignment: .leading, spacing: 8) {
                    Text(jobApplication.title)
                        .font(.headline)
                    VStack(alignment: .leading, spacing: 2) {
                        Label(jobPosting.companyName, systemImage: "building.2")
                        Label(jobPosting.jobPositionName, systemImage: "figure.walk")
                        Label(jobApplication.createdAt.formatted(), systemImage: "gauge.with.needle")
                    }
                    .font(.caption2)
                }
            } else {
                Text("Loading...")
            }
        }
        .onAppear {
            self.jobPosting = model.fetchJobPosting(
                associatedWith: jobApplication
            )
        }
        
        
    }
}
