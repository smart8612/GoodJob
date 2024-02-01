//
//  NewJobApplicaitonView.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/20/24.
//

import SwiftUI


struct NewJobApplicaitonView: View {
    
    @StateObject private var model = GJNewJobApplicationViewModel()
    
    @State private var isShowingJobPostingSelectionSheet = false
    @Binding var isShowingSheet: Bool
    
    var body: some View {
        DataCreationContainer(
            isShowingSheet: $isShowingSheet,
            addAction: addAction
        ) {
            Form {
                Section {
                    TextField("Job Application Title", text: $model.title)
                }
                
                Section {
                    Button(action: { isShowingJobPostingSelectionSheet.toggle() }) {
                        Text(model.selectedJobPosting?.jobPositionName ?? NSLocalizedString("Select a posting", comment: .init()))
                    }
                    .sheet(isPresented: $isShowingJobPostingSelectionSheet) {
                        JobPostingSelectionView()
                    }
                }
            }
            .navigationTitle("New Job Application")
            .environmentObject(model)
        }
    }
    
    private func addAction() {
        model.createJobApplication()
        isShowingSheet.toggle()
    }
    
}

struct JobPostingSelectionView: View {
    
    @EnvironmentObject private var model: GJNewJobApplicationViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            Group {
                if model.registableJobPostings.isEmpty {
                    Text("Empty Job Posting")
                        .foregroundStyle(.secondary)
                } else {
                    List(model.registableJobPostings) { post in
                        Button(action: { model.selectedJobPosting = post }) {
                            HStack {
                                Text("\(post.jobPositionName) @ \(post.companyName)")
                                Spacer()
                                if let _ = model.selectedJobPosting, post == model.selectedJobPosting {
                                    Text("✅")
                                }
                            }
                        }
                    }
                }
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
