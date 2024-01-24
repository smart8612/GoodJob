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
                .onAppear(perform: model.fetchJobPostings)
            } sheet: { isShowingSheet in
                 NewJobPostingView(isShowingSheet: isShowingSheet)
            }
            .navigationTitle(navigationModel.selectedCategory.name)
            .environmentObject(model)
            
        }
       
    }
    
}


fileprivate struct JobPostingCellView: View {
    
    let jobPosting: GJJobPosting
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            HStack {
                Text(jobPosting.jobPositionName)
            }
            Spacer()
            HStack {
                Label(jobPosting.companyName, systemImage: "building")
                Divider()
                Label(jobPosting.endDate.formatted(), systemImage: "calendar")
            }
            .lineLimit(1)
            Spacer()
        }
    }
}

