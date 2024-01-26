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
    
    let addTestAction: (() -> Void)?
    
    private var enumeratedTests: [(Int, GJTest)] {
        Array(tests.enumerated())
    }
    
    var body: some View {
        
        Form {
            Section {
                TextField("Company Name",
                          text: $jobPosting.companyName)
            }
            
            Section {
                TextField("Job Position",
                          text: $jobPosting.jobPositionName)
                TextField("Workplace Location",
                          text: $jobPosting.workplaceLocation)
                TextField("Recruitment Numbers",
                          text: $jobPosting.recruitNumbers)
                TextField("Job Posting Link",
                          text: $jobPosting.link)
            }
            
            Section {
                DatePicker(selection: $jobPosting.startDate) {
                    Text("Starts")
                }
                DatePicker(selection: $jobPosting.endDate) {
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
                Button("Add Tests", action: { addTestAction?() })
            }
        }
    }
    
    private func changeTestType(testType: GJTest.TestType, index: Int) {
        tests[index].type = testType
    }
    
}
