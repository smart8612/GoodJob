//
//  JobApplicationDetailView.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/21/24.
//

import SwiftUI


struct JobApplicationDetailView: View {
    
    @StateObject var model: GJJobApplicationDetailViewModel
    
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
                    Section("Information") {
                        Text(jobApplication.title)
                        Text(jobApplication.createdAt.formatted())
                    }
                    
                    Section("Relative Job Posting") {
                        Button(action: { isShowingJobPostingDetailSheet.toggle() }) {
                            VStack(alignment: .leading) {
                                Text(jobPosting.companyName)
                                Text(jobPosting.jobPositionName)
                            }
                        }
                        
                    }
                    Section("Recruit Tests") {
                        ForEach(tests) { test in
                            TestRecordSectionView(test: test)
                        }
                    }
                    
                }
                .sheet(isPresented: $isShowingJobPostingDetailSheet) {
                    NavigationStack {
                        JobPostingDetailView(model: .init(
                            selectedJobPostingId: jobPosting.id
                        ))
                        .toolbar {
                            ToolbarItem(placement: .topBarLeading) {
                                Button(action: { isShowingJobPostingDetailSheet.toggle() }) {
                                    Text("Close")
                                }
                            }
                        }
                    }
                }
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

struct TestRecordSectionView: View {
    
    @EnvironmentObject private var model: GJJobApplicationDetailViewModel
    
    @State private var isShowingSheet: Bool = false
    let test: GJTest
    
    var body: some View {
        Button(action: { isShowingSheet.toggle() }) {
            VStack(alignment: .leading) {
                Text(test.type.description)
                Text(test.name)
                
                if let testRecord = model.fetchTestRecord(belongsTo: test) {
                    Text("Test Record")
                    Text (testRecord.memo)
                }
            }
        }
        .sheet(isPresented: $isShowingSheet) {
            NewTestRecordView(isShowingSheet: $isShowingSheet, test: test)
        }
    }
    
}

struct NewTestRecordView: View {
    
    @EnvironmentObject private var model: GJJobApplicationDetailViewModel
    
    @Binding var isShowingSheet: Bool
    let test: GJTest
    
    @State private var testRecord: GJTestRecord = .initWithEmpty()
    
    var body: some View {
        DataCreationContainer(
            isShowingSheet: $isShowingSheet,
            addAction: addAction
        ) {
            List {
                Section("Memo") {
                    TextField("Memo", text: $testRecord.memo)
                }
            }
            .navigationTitle("New Test Record")
        }
    }
    
    private func addAction() {
        model.create(testRecord: testRecord, belongsTo: test)
        isShowingSheet.toggle()
    }
    
}
