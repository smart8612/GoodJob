//
//  JobPostingOperationView.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/26/24.
//

import SwiftUI


struct JobPostingOperationView: View {
    
    @Binding var jobPosting: GJJobPosting
    @Binding var tests: [GJTest]
    
    @State private var editMode: EditMode = .active
    
    let addTestAction: (() -> Void)?
    
    private var enumeratedTests: [(Int, GJTest)] {
        Array(tests.enumerated())
    }
    
    var body: some View {
        
        Form {
            Section {
                TextField("Company Name",
                          text: $jobPosting.companyName)
                .keyboardType(.default)
            }
            
            Section {
                TextField("Job Position",
                          text: $jobPosting.jobPositionName)
                .keyboardType(.default)
                TextField("Workplace Location",
                          text: $jobPosting.workplaceLocation)
                .keyboardType(.default)
                TextField("Recruitment Numbers",
                          text: $jobPosting.recruitNumbers)
                .keyboardType(.numberPad)
                TextField("Job Posting Link",
                          text: $jobPosting.link)
                .keyboardType(.URL)
            }
            
            Section {
                DatePicker(selection: $jobPosting.startDate) {
                    Text("Starts")
                }
                DatePicker(selection: $jobPosting.endDate, in: jobPosting.startDate...) {
                    Text("Ends")
                }
            }
            
            Section {
                ForEach(enumeratedTests, id: \.1.id) { index, test in
                    HStack {
                        Menu(test.type.description) {
                            ForEach(GJTest.TestType.allCases) { testType in
                                Button(action: { changeTestType(testType: testType, index: index) }) {
                                    Text(testType.description)
                                }
                            }
                        }
                        Divider()
                        TextField(
                            "Test Name",
                            text: $tests[index].name
                        )
                    }
                }
                .onDelete(perform: deleteTest)
                .onMove(perform: moveTest)
                Button("Add Tests", action: { addTestAction?() })
            }
        }
        .environment(\.editMode, $editMode)
    }
    
    private func deleteTest(at indexSet: IndexSet) {
        tests.remove(atOffsets: indexSet)
    }
    
    private func moveTest(from source: IndexSet, to destination: Int) {
        tests.move(fromOffsets: source, toOffset: destination)
    }
    
    private func changeTestType(testType: GJTest.TestType, index: Int) {
        tests[index].type = testType
    }
    
}
