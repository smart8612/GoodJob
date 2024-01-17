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
        
        List {
            ForEach(model.jobPostings) {
                JobPostingCellView(jobPosting: $0)
            }
            .onDelete(perform: model.deleteJobPostings)
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
    
}
