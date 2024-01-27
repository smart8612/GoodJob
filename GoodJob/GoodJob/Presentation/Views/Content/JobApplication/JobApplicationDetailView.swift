//
//  JobApplicationDetailView.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/21/24.
//

import SwiftUI


struct JobApplicationDetailView: View {
    
    @StateObject var model: GJJobApplicationDetailViewModel
    
    @State private var isShowingSheet = false
    @State private var isShowingJobPostingDetailSheet = false
    
    private var selectedJobApplicationId: UUID? {
        model.selectedJobApplicationId
    }
    
    private var jobApplication: GJJobApplication? {
        model.jobApplication
    }
    
    private var jobPosting: GJJobPosting? {
        model.jobPosting
    }
    
    private var tests: [GJTest]? {
        model.tests
    }
    
    var body: some View {
        Group {
            if let jobApplication = jobApplication,
               let jobPosting = jobPosting,
               let tests = tests {
                List {
                    Section {
                        Text(jobApplication.title)
                        Text(jobApplication.createdAt.formatted())
                    }
                    
                    Section {
                        Text(jobPosting.companyName)
                        Text(jobPosting.jobPositionName)
                    }
                    
                    Section {
                        ForEach(tests) { test in
                            Button(action: { isShowingSheet.toggle() }) {
                                VStack(alignment: .leading) {
                                    Text(test.type.description)
                                    Text(test.name)
                                }
                            }
                        }
                    }
                }
                .sheet(isPresented: $isShowingSheet) {
                    NewTestRecordView(isShowingSheet: $isShowingSheet)
                }
//                .sheet(isPresented: $isShowingJobPostingDetailSheet) {
//                    JobPostingDetailView()
//                }
            } else {
                Text("Select a Job Application")
            }
        }
        .navigationTitle("Job Application Detail")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            EditButton()
        }
        .environmentObject(model)
        .onAppear {
            model.fetchJobApplication()
        }
    }
    
}

struct NewTestRecordView: View {
    
    @Binding var isShowingSheet: Bool
    
    
    var body: some View {
        DataCreationContainer(isShowingSheet: $isShowingSheet) {
            Text("Hello World")
                .navigationTitle("New Test Record")
        }
    }
    
    
}
