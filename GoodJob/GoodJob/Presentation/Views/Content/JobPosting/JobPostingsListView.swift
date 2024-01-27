//
//  JobPostingsListView.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/15/24.
//

import SwiftUI


struct JobPostingsListView: View {
    
    @StateObject private var model = GJJobPostingViewModel()
    @EnvironmentObject private var navigationModel: GJNavigationModel
    
    var body: some View {
        
        NavigationStack {
            DataContainer {
                List {
                    ForEach(model.jobPostings) { jobPost in
                        NavigationLink(value: jobPost) {
                            JobPostingCellView(jobPosting: jobPost)
                        }
                    }
                    .onDelete(perform: model.deleteJobPostings)
                }
                .navigationDestination(for: GJJobPosting.self) {
                    JobPostingDetailView(model: .init(
                        selectedJobPostingId: $0.id
                    ))
                }
            } sheet: { isShowingSheet in
                 NewJobPostingView(isShowingSheet: isShowingSheet)
            }
            .navigationTitle(navigationModel.selectedCategory.name)
        }
       
    }
    
}


fileprivate struct JobPostingCellView: View {
    
    let jobPosting: GJJobPosting
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(jobPosting.jobPositionName)
                .font(.headline)
            VStack(alignment: .leading) {
                Label(jobPosting.companyName, systemImage: "building.2")
                Label(jobPosting.workplaceLocation, systemImage: "globe")
                Label(jobPosting.endDate.formatted(), systemImage: "calendar")
            }
            .font(.caption2)
        }
    }
}

