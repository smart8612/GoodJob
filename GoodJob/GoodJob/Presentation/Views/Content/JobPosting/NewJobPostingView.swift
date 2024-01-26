//
//  NewJobPostingView.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/15/24.
//

import SwiftUI


struct NewJobPostingView: View {
    
    @StateObject private var model = GJNewJobPostingViewModel()
    @Binding var isShowingSheet: Bool
    
    var body: some View {
        
        DataCreationContainer(isShowingSheet: $isShowingSheet, addAction: addAction) {
            Form {
                Section {
                    TextField("Company Name", 
                              text: $model.newJobPosting.companyName)
                }
                
                Section {
                    TextField("Job Position", 
                              text: $model.newJobPosting.jobPositionName)
                    TextField("Workplace Location", 
                              text: $model.newJobPosting.workplaceLocation)
                    TextField("Recruitment Numbers", 
                              text: $model.newJobPosting.recruitNumbers)
                    TextField("Job Posting Link", 
                              text: $model.newJobPosting.link)
                }
                
                Section {
                    DatePicker(selection: $model.newJobPosting.startDate) {
                        Text("Starts")
                    }
                    DatePicker(selection: $model.newJobPosting.endDate) {
                        Text("Ends")
                    }
                }
                
                Section {
                    TestSectionView()
                    Button("Add Tests", action: model.addEmptyTest)
                }
            }
            .navigationTitle("New Job")
            .environmentObject(model)
        }
        
    }
    
    private func addAction() {
        model.createNewJobPosting()
        isShowingSheet.toggle()
    }
    
}

struct TestSectionView: View {
    
    @EnvironmentObject private var model: GJNewJobPostingViewModel
    
    var body: some View {
        ForEach(model.enumeratedTests, id: \.1.id) { index, test in
            HStack {
                Menu(test.type.description) {
                    ForEach(GJTest.TestType.allCases) { testType in
                        Button(action: { model.changeTestType(to: testType, at: index) }) {
                            Text(testType.description)
                        }
                    }
                }
                Divider()
                TextField(
                    "Test Name",
                    text: $model.newTests[index].name
                )
            }
        }
    }
    
}
