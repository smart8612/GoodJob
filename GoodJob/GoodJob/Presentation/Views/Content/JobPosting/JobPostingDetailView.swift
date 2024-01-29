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
                        JobPostingDetailCell(key: "Company Name") {
                            Text(jobPosting.companyName)
                        }
                    }
                    
                    Section("Job Position Information") {
                        JobPostingDetailCell(key: "Job Position") {
                            Text(jobPosting.jobPositionName)
                        }
                        JobPostingDetailCell(key: "Workplace Location") {
                            Text(jobPosting.workplaceLocation)
                        }
                        JobPostingDetailCell(key: "Recruitment Numbers") {
                            Text(jobPosting.recruitNumbers)
                        }
                        JobPostingDetailCell(key: "Job Posting Link") {
                            Button(jobPosting.link) {
                                openURL(URL(string: jobPosting.link)!)
                            }
                            .foregroundStyle(Color.init(uiColor: UIColor.link))
                        }
                    }
                    
                    Section("Schedule") {
                        JobPostingDetailCell(key: "Starts") {
                            Text(jobPosting.startDate.formatted())
                        }
                        JobPostingDetailCell(key: "Ends") {
                            Text(jobPosting.endDate.formatted())
                        }
                    }
                    
                    Section("Process Information") {
                        ForEach(tests) { test in
                            JobPostingDetailCell(key: test.type.description) {
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

struct JobPostingDetailCell<Content: View>: View {
    
    let key: String
    let content: () -> Content
    
    init(key: String, @ViewBuilder content: @escaping () -> Content) {
        self.key = key
        self.content = content
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(key)
                .font(.caption)
                .foregroundStyle(.secondary)
            content()
                .font(.body)
                .foregroundStyle(.primary)
        }
    }
}
