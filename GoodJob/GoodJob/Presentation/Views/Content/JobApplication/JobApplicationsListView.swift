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
        
        NavigationStack(path: $navigationModel.jobApplicationPath) {
            DataContainer {
                if model.jobApplications.isEmpty {
                    Text("Empty Job Application")
                        .foregroundStyle(.secondary)
                } else {
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
            } sheet: { isShowingSheet in
                NewJobApplicaitonView(isShowingSheet: isShowingSheet)
            }
            .navigationTitle(navigationModel.selectedCategory.name)
        }
    }
    
}


fileprivate struct JobApplicationCellView: View {
    
    let jobApplication: GJJobApplication
    
    private let jobPostingController: GJJobPostingController = {
        GJJobPostingController(
            jobPostingRepository: GJJobPostingRepository(),
            testRepository: GJTestRepository()
        )
    }()
    
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
            do {
                self.jobPosting =  try jobPostingController.fetchJobPosting(with: jobApplication.jobPostingId)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
