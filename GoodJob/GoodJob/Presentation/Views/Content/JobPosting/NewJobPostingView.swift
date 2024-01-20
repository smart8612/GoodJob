//
//  NewJobPostingView.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/15/24.
//

import SwiftUI


struct NewJobPostingView: View {
    
    @EnvironmentObject var model: GoodJobManager
    
    @Binding var isShowingSheet: Bool
    @State private var isShowingConfirmationlDialog = false
    
    private let title = "Are you sure want to discard this new job posting?"
    
    @State private var jobPosting = GJJobPosting.initWithEmpty()
    
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Company Name", text: $jobPosting.companyName)
                }
                
                Section {
                    TextField("Job Position", text: $jobPosting.jobPositionName)
                    TextField("Workplace Location", text: $jobPosting.workplaceLocation)
                    TextField("Recruitment Numbers", text: $jobPosting.recruitNumbers)
                    TextField("Job Posting Link", text: $jobPosting.link)
                }
                
                Section {
                    DatePicker(selection: $jobPosting.startDate, label: { Text("Starts") })
                    DatePicker(selection: $jobPosting.endDate, label: { Text("Ends") })
                }
                
                Section {
                    TestSectionView(jobPosting: $jobPosting)
                    Button("Add Tests", action: addTest)
                }
            }
            .navigationTitle("New Job")
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
                            isShowingSheet = false
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
            isShowingSheet.toggle()
        }
    }
    
    private func addTest() {
        withAnimation {
            jobPosting.tests.append(.initWithEmpty())
        }
    }
    
}

#Preview {
    NewJobPostingView(isShowingSheet: .constant(true))
        .environmentObject(
            GoodJobManager(
                persistenceController: .init(inMemory: true)
            )
        )
}

struct TestSectionView: View {
    
    @Binding var jobPosting: GJJobPosting
    
    private var enumeratedTests: [(Int, GJTest)] {
        Array(jobPosting.tests.enumerated())
    }
    
    var body: some View {
        ForEach(enumeratedTests, id: \.1.id) { index, _ in
            HStack {
                Menu(jobPosting.tests[index].type.description) {
                    ForEach(GJTest.TestType.allCases) { (testType: GJTest.TestType) in
                        Button(action: { changeTestType(to: testType, at: index) }) {
                            Text(testType.description)
                        }
                    }
                }
                Divider()
                TextField(
                    "Test Name",
                    text: $jobPosting.tests[index].name
                )
            }
        }
    }
    
    private func changeTestType(to newTestType: GJTest.TestType, at index: Int) {
        jobPosting.tests[index].type = newTestType
    }
    
}
