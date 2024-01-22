//
//  JobPostingsListView.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/15/24.
//

import SwiftUI


struct JobPostingsListView: View {
    
    @EnvironmentObject private var model: GJAppController
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
