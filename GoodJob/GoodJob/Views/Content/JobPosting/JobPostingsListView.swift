//
//  JobPostingsListView.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/15/24.
//

import SwiftUI
import CoreData


struct JobPostingsListView: View {
    
    @StateObject private var jobPostingManager = JobPostingManager()

    @FetchRequest(entity: JobPosting.entity(), sortDescriptors: [])
    private var jobPostings: FetchedResults<JobPosting>
    
    @State var selectedJobPosting: JobPosting?
    @State var isPresentingNewJobPosting = false
    
    var body: some View {
        
        List {
            ForEach(jobPostings) {
                JobPostingCellView(jobPosting: $0)
            }
            .onDelete(perform: deleteItems)
        }
        .listStyle(.insetGrouped)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
            
            ToolbarItem {
                Button(action: addItem, label: {
                    Label("Add Item", systemImage: "plus")
                })
            }
        }
        .sheet(isPresented: $isPresentingNewJobPosting) {
            NewJobPostingView(
                isPresentingNewJobPosting: $isPresentingNewJobPosting
            )
            .environmentObject(jobPostingManager)
        }
       
    }
    
    private func addItem() {
        isPresentingNewJobPosting.toggle()
        
        withAnimation {
//            let newItem = Item(context: viewContext)
//            newItem.timestamp = Date()
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            //offsets.map { jobPostings[$0] }.forEach(viewContext.delete)
        }
    }
    
}
