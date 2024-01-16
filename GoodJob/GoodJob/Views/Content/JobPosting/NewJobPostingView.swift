//
//  NewJobPostingView.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/15/24.
//

import SwiftUI


struct NewJobPostingView: View {
    
    @EnvironmentObject var jobPostingManager: JobPostingManager
    
    @Binding var isPresentingNewJobPosting: Bool
    @State private var isShowingConfirmationlDialog = false
    
    private let title = "Are you sure want to discard this new job posting?"
    
    @State private var isEditing = false
    
    @State private var companyName: String = ""
    @State private var jobPosition: String = ""
    @State private var workplaceLocation: String = ""
    @State private var recruitNumbers: String = ""
    @State private var link: String = ""
    
    @State private var startDate: Date = Date()
    @State private var endDate: Date = Date()
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Company Name", text: $companyName)
                }
                
                Section {
                    TextField("Job Position", text: $jobPosition)
                    TextField("Workplace Location", text: $workplaceLocation)
                    TextField("Recruitment Numbers", text: $recruitNumbers)
                    TextField("Job Posting Link", text: $link)
                }
                
                Section {
                    DatePicker(selection: $startDate, label: { Text("Starts") })
                    DatePicker(selection: $endDate, label: { Text("Ends") })
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
        jobPostingManager.createJobPosting { jobPosting in
            jobPosting.company?.name = companyName
            jobPosting.positionName = jobPosition
            jobPosting.workplaceLocation = workplaceLocation
            jobPosting.recruitNumbers = Int64(recruitNumbers) ?? 0
            jobPosting.webLink = URL(string: link)
            jobPosting.startDate = startDate
            jobPosting.endDate = endDate
        }
    }
    
}
