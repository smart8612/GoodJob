//
//  EditJobPostingView.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/26/24.
//

import SwiftUI


struct EditJobPostingView: View {
    
    private let jobPostingController: GJJobPostingController = {
        GJJobPostingController(
            jobPostingRepository: GJJobPostingRepository(),
            testRepository: GJTestRepository()
        )
    }()
    
    @Binding var isShowingSheet: Bool
    
    @State var jobPosting: GJJobPosting
    @State var tests: [GJTest]
    
    var body: some View {
        
        DataCreationContainer(isShowingSheet: $isShowingSheet, addAction: addAction) {
            JobPostingOperationView(
                jobPosting: $jobPosting,
                tests: $tests,
                addTestAction: addTestAction
            )
            .navigationTitle("Edit Job")
        }
        
    }
    
    private func addAction() {
        do {
            try jobPostingController.update(jobPosting: jobPosting, tests: tests)
            isShowingSheet.toggle()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func addTestAction() {
        tests.append(.initWithEmpty())
    }
    
    
}

