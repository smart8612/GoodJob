//
//  JobPostingsListView.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/15/24.
//

import SwiftUI


struct JobPostingsListView: View {
    
    @EnvironmentObject private var model: GoodJobManager
    
    @State var isPresentingNewJobPosting = false
    
    var body: some View {
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
        .sheet(isPresented: $isPresentingNewJobPosting) {
            NewJobPostingView(
                isPresentingNewJobPosting: $isPresentingNewJobPosting
            )
            .environmentObject(model)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
            
            ToolbarItem {
                Button(action: { isPresentingNewJobPosting.toggle() }) {
                    Label("Add Item", systemImage: "plus")
                }
            }
        }
    }
    
}
