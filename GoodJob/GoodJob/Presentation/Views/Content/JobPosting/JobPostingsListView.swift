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
        
        DataContainer {
            List(selection: $navigationModel.selectedJobPosting) {
                ForEach(model.jobPostings) { jobPost in
                    NavigationLink(value: jobPost) {
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
