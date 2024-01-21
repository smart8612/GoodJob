//
//  NewJobApplicaitonView.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/20/24.
//

import SwiftUI

struct NewJobApplicaitonView: View {
    
    @EnvironmentObject private var model: GJAppController
    @Binding var isShowingSheet: Bool
    
    @State private var title: String = .init()
    @State private var selectedJobPosting: GJJobPosting? = nil
    @State private var isShowingJobPostingSelectionSheet = false
    
    var body: some View {
        DataCreationContainer(isShowingSheet: $isShowingSheet, addAction: save) {
            Form {
                Section {
                    TextField("Job Application Title", text: $title)
                }
                
                Section {
                    Button(action: { isShowingJobPostingSelectionSheet.toggle() }) {
                        Text(selectedJobPosting?.jobPositionName ?? "Select a posting")
                    }
                    .sheet(isPresented: $isShowingJobPostingSelectionSheet) {
                        JobPostingSelectionView(
                            selectedJobPosting: $selectedJobPosting
                        )
                    }
                }
            }
            .navigationTitle("New Job Application")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private func save() {
        if let selectedJobPosting = selectedJobPosting {
            let _ = model.create(
                jobApplication: .init(
                    jobPostingId: selectedJobPosting.id,
                    title: title
                )
            )
        }
        isShowingSheet.toggle()
    }
    
}

struct JobPostingSelectionView: View {
    
    @EnvironmentObject private var model: GJAppController
    
    @Binding var selectedJobPosting: GJJobPosting?
    @Environment(\.dismiss) private var dismiss
    
    private var jobPostings: [GJJobPosting] {
        model.fetchJobApplicationRegistableJobPostings()
    }
    
    var body: some View {
        NavigationStack {
            List(jobPostings) { post in
                Button(action: { selectedJobPosting = post }, label: {
                    HStack {
                        if let _ = selectedJobPosting, post == selectedJobPosting {
                            Text("✅")
                        }
                        Text("\(post.jobPositionName) @ \(post.companyName)")
                    }
                })
            }
            .navigationTitle("Choose a Job Posting")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: { dismiss() }) {
                        Text("Cancel")
                    }
                }
            }
        }
        
    }
    
}
