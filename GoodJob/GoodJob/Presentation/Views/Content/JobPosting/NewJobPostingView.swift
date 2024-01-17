//
//  NewJobPostingView.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/15/24.
//

import SwiftUI


struct NewJobPostingView: View {
    
    @EnvironmentObject var model: GoodJobManager
    
    @Binding var isPresentingNewJobPosting: Bool
    @State private var isShowingConfirmationlDialog = false
    @State private var isEditing = false
    
    private let title = "Are you sure want to discard this new job posting?"
    
    @State private var jobPosting = GJJobPosting.initWithEmpty()
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Company Name", text: $jobPosting.companyName)
                }
                
                Section {
                    TextField("Job Position", text: $jobPosting.jobPostitionName)
                    TextField("Workplace Location", text: $jobPosting.workplaceLocation)
                    TextField("Recruitment Numbers", text: $jobPosting.recruitNumbers)
                    TextField("Job Posting Link", text: $jobPosting.link)
                }
                
                Section {
                    DatePicker(selection: $jobPosting.startDate, label: { Text("Starts") })
                    DatePicker(selection: $jobPosting.endDate, label: { Text("Ends") })
                }
            }
            .navigationTitle("Hello World")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        isShowingConfirmationlDialog = true
                        print("Cancel Button Clicked")
                    }
                    .confirmationDialog(
                        title,
                        isPresented: $isShowingConfirmationlDialog,
                        titleVisibility: .visible
                    ) {
                        Button("Discard Changes", role: .destructive) {
                            isPresentingNewJobPosting = false
                        }
                        Button("Keep Editing", role: .cancel) {
                            isShowingConfirmationlDialog = false
                        }
                    }
                    
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add", action: createJobPosting)
                }
            }
        }
        
    }
    
    private func createJobPosting() {
        withAnimation {
            model.create(jobPosting: jobPosting)
            isPresentingNewJobPosting.toggle()
        }
    }
    
}
