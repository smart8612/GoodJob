//
//  NewJobPostingView.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/15/24.
//

import SwiftUI


struct NewJobPostingView: View {
    
    @EnvironmentObject var model: GJAppController
    
    @Binding var isShowingSheet: Bool
    
    @State private var jobPosting = GJJobPosting.initWithEmpty()
    
    var body: some View {
        
        DataCreationContainer(isShowingSheet: $isShowingSheet, addAction: addAction) {
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
        }
        
    }
    
    private func addAction() {
        model.create(jobPosting: jobPosting)
        isShowingSheet.toggle()
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
            GJAppController(
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
