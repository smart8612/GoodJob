//
//  JobPostingDetailView.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/19/24.
//

import SwiftUI


struct JobPostingDetailView: View {
    
    @StateObject var model: GJJobPostingDetailViewModel
    
    @State private var isShowingSheet = false
    
    private var jobPosting: GJJobPosting? {
        model.jobPosting
    }
    
    private var tests: [GJTest]? {
        model.tests
    }
    
    var body: some View {
        Group {
            if let jobPosting = jobPosting, let tests = tests {
                List {
                    Section {
                        Text("Company Name: \(jobPosting.companyName)")
                    }
                    
                    Section {
                        Text("Job Position: \(jobPosting.jobPositionName)")
                        Text("Workplace Location: \(jobPosting.workplaceLocation)")
                        Text("Recruitment Numbers: \(jobPosting.recruitNumbers)")
                        Text("Job Posting Link: \(jobPosting.link)")
                    }
                    
                    Section {
                        Text("Starts: \(jobPosting.startDate.formatted())")
                        Text("Ends: \(jobPosting.endDate.formatted())")
                    }
                    
                    Section {
                        ForEach(tests) { test in
                            HStack {
                                Text(test.type.description)
                                Divider()
                                Text(test.name)
                            }
                        }
                    }
                }
                .sheet(isPresented: $isShowingSheet) {
                    EditJobPostingView(
                        isShowingSheet: $isShowingSheet,
                        jobPosting: jobPosting,
                        tests: tests
                    )
                }
            } else {
                Text("Select a Job Posting")
            }
        }
        .environmentObject(model)
        .navigationTitle("Jobs Details")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: { isShowingSheet.toggle() }) {
                    Text("Edit")
                }
            }
        }
        .onAppear { model.fetchJobPosting() }
    }
    
}
