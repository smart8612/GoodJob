//
//  JobPostingsListView.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/15/24.
//

import SwiftUI


struct JobPostingsListView: View {
    
    @EnvironmentObject private var model: GoodJobManager
    
    var body: some View {
        DataContainer {
            List {
                ForEach(model.jobPostings) { jobPost in
                    NavigationLink {
                        JobPostingDetailView(jobPostingId: jobPost.id)
                    } label: {
                        JobPostingCellView(jobPosting: jobPost)
                    }
                }
                .onDelete(perform: model.deleteJobPostings)
            }
            .listStyle(.insetGrouped)
        } sheet: { isShowingSheet in
            NewJobPostingView(isShowingSheet: isShowingSheet)
        }
    }
    
}
