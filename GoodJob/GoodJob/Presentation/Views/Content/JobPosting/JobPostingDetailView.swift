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
    
    @Environment(\.openURL) var openURL
    
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
                    Section("Company Information") {
                        SecondaryLabeledCell(key: "Company Name") {
                            Text(jobPosting.companyName)
                        }
                    }
                    
                    Section("Job Position Information") {
                        SecondaryLabeledCell(key: "Job Position") {
                            Text(jobPosting.jobPositionName)
                        }
                        SecondaryLabeledCell(key: "Workplace Location") {
                            Text(jobPosting.workplaceLocation)
                        }
                        SecondaryLabeledCell(key: "Recruitment Numbers") {
                            Text(jobPosting.recruitNumbers)
                        }
                        SecondaryLabeledCell(key: "Job Posting Link") {
                            Group {
                                if let url = URL(string: jobPosting.link) {
                                    Button(jobPosting.link) {
                                        openURL(url)
                                    }
                                    .foregroundStyle(Color.init(uiColor: UIColor.link))
                                } else {
                                    Text(jobPosting.link)
                                }
                            }
                        }
                    }
                    
                    Section("Schedule") {
                        SecondaryLabeledCell(key: "Starts") {
                            Text(jobPosting.startDate.formatted())
                        }
                        SecondaryLabeledCell(key: "Ends") {
                            Text(jobPosting.endDate.formatted())
                        }
                    }
                    
                    Section("Process Information") {
                        ForEach(tests) { test in
                            SecondaryLabeledCell(key: test.type.description) {
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
