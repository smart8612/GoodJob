//
//  JobApplicationDetailView.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/21/24.
//

import SwiftUI


struct JobApplicationDetailView: View {
    
    @StateObject var model: GJJobApplicationDetailViewModel
    
    var body: some View {
        
        Group {
            if let jobApplication = model.jobApplication,
               let jobPosting = model.jobPosting,
               let tests = model.tests {
                JobApplicationDetailListView(
                    jobApplication: jobApplication,
                    jobPosting: jobPosting,
                    tests: tests
                )
            } else {
                Text("Select a Job Application")
            }
        }
        .navigationTitle("Job Application Detail")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar { EditButton() }
        .environmentObject(model)
        .onAppear { model.fetchJobApplication() }
        
    }
    
}


fileprivate struct JobApplicationDetailListView: View {
    
    let jobApplication: GJJobApplication
    let jobPosting: GJJobPosting
    let tests: [GJTest]
    
    @State private var isShowingSheet = false
    
    var body: some View {
        
        List {
            Section("Information") {
                Text(jobApplication.title)
                Text(jobApplication.createdAt.formatted())
            }
            
            Section("Relative Job Posting") {
                Button(action: { isShowingSheet.toggle() }) {
                    Label("\(jobPosting.jobPositionName) @ \(jobPosting.companyName)", systemImage: "link")
                }
                
            }
            
            ForEach(tests) { test in
                Section {
                    TestRecordView(test: test)
                }
            }
        }
        .sheet(isPresented: $isShowingSheet) {
            AssociatedJobPostingView(jobPosting: jobPosting)
        }
        
    }
}


fileprivate struct TestRecordView: View {
    
    @EnvironmentObject private var model: GJJobApplicationDetailViewModel
    
    let test: GJTest
    @State private var isShowingNewSheet: Bool = false

    private var testRecord: GJTestRecord? {
        guard let testRecord = model.testRecords?[test] else {
            return nil
        }
        return testRecord
    }
    
    var body: some View {
        
        Group {
            SecondaryLabeledCell(key: test.type.description) {
                Text(test.name)
            }
            
            if let testRecord = testRecord {
                TestRecordCell(testRecord: testRecord)
            } else {
                Button(action: { isShowingNewSheet.toggle() }) {
                    Label("Add Test Record", systemImage: "plus.app")
                }
                .sheet(isPresented: $isShowingNewSheet) {
                    NewTestRecordView(
                        isShowingSheet: $isShowingNewSheet,
                        test: test
                    )
                }
            }
        }
        .onAppear { model.fetchJobApplication() }
        
    }
    
}

fileprivate struct TestRecordCell: View {
    
    @EnvironmentObject private var model: GJJobApplicationDetailViewModel
    
    let testRecord: GJTestRecord
    private var testRecords: [GJTestRecord] { [testRecord] }
    
    @State private var isShowingEditSheet: Bool = false
    
    var body: some View {
        
        ForEach(testRecords) { _ in
            Button(action: { isShowingEditSheet.toggle() }) {
                SecondaryLabeledCell(key: "Test Record") {
                    HStack {
                        Text(testRecord.memo)
                        Spacer()
                        Text(testRecord.result.description)
                    }
                }
            }
            
        }
        .onDelete(perform: deleteTestRecord)
        .sheet(isPresented: $isShowingEditSheet) {
            EditTestRecordView(
                isShowingSheet: $isShowingEditSheet,
                testRecord: testRecord
            )
        }
        
    }
    
    private func deleteTestRecord(at indexSet: IndexSet) {
        let testRecords = testRecords
        indexSet
            .compactMap { testRecords[$0] }
            .forEach { model.delete(testRecord: $0) }
    }
    
}

fileprivate struct AssociatedJobPostingView: View {
    
    let jobPosting: GJJobPosting
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        
        NavigationStack {
            JobPostingDetailView(model: .init(
                selectedJobPostingId: jobPosting.id
            ))
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: { dismiss() }) {
                        Text("Close")
                    }
                }
            }
        }
        
    }
    
}
