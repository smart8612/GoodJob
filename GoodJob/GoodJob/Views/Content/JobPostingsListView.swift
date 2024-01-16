//
//  JobPostingsListView.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/15/24.
//

import SwiftUI
import CoreData


struct JobPostingsListView: View {
    
    @Environment(\.managedObjectContext) private var viewContext

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
        }
       
    }
    
    private func addItem() {
        isPresentingNewJobPosting.toggle()
        
//        withAnimation {
////            let newItem = Item(context: viewContext)
////            newItem.timestamp = Date()
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { jobPostings[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
}
