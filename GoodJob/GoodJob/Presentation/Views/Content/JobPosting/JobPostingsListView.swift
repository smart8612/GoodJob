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
                    JobPostingDetailView(selectedJobPostingId: $0.id)
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
        HStack(spacing: 18) {
            Image(systemName: "building.2")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
            VStack(alignment: .leading) {
                Text(jobPosting.jobPositionName)
                    .font(.headline)
                Text(jobPosting.companyName)
                    .font(.subheadline)
                Text(jobPosting.workplaceLocation)
                    .font(.caption)
                Text(jobPosting.endDate.formatted())
                    .font(.caption2)
            }
        }
    }
}

