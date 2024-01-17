//
//  JobPostingsListView.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/15/24.
//

import SwiftUI


struct JobPostingsListView: View {
    
    @StateObject private var model = GoodJobManager()
    
    @State var selectedJobPosting: GJJobPosting?
    @State var isPresentingNewJobPosting = false
    
    var body: some View {
        
        List(model.jobPostings) {
            JobPostingCellView(jobPosting: $0)
                // .onDelete(perform: deleteItems)
        }
        .listStyle(.insetGrouped)
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
        .sheet(isPresented: $isPresentingNewJobPosting) {
            NewJobPostingView(
                isPresentingNewJobPosting: $isPresentingNewJobPosting
            )
            .environmentObject(model)
        }
       
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            //offsets.map { jobPostings[$0] }
            //    .forEach(jobPostingManager.delete)
        }
    }
    
}
