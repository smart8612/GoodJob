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
    @State private var isShowingSheet: Bool = false
    
    private var testRecord: GJTestRecord? {
        guard let testRecord = model.testRecords?[test] else {
            return nil
        }
        return testRecord
    }
    
    private var testRecords: [GJTestRecord] {
        guard let testRecord = testRecord else {
            return .init()
        }
        return [testRecord]
    }
    
    var body: some View {
        
        Group {
            SecondaryLabeledCell(key: test.type.description) {
                Text(test.name)
            }
            
            if let testRecord = testRecord {
                ForEach(testRecords) { _ in
                    SecondaryLabeledCell(key: "Test Record") {
                        Text(testRecord.memo)
                    }
                }
                .onDelete(perform: deleteTestRecord)
            } else {
                Button(action: { isShowingSheet.toggle() }) {
                    Label("Add Test Record", systemImage: "plus.app")
                }
            }
            
        }
        .sheet(isPresented: $isShowingSheet) {
            NewTestRecordView(
                isShowingSheet: $isShowingSheet,
                test: test
            )
        }
        .onAppear { model.fetchJobApplication() }
        
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

fileprivate struct NewTestRecordView: View {
    
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
