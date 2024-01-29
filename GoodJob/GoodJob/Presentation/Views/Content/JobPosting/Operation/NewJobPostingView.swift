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
            JobPostingOperationView(
                jobPosting: $model.newJobPosting,
                tests: $model.newTests,
                addTestAction: model.addEmptyTest
            )
            .navigationTitle("New Job")
            .environmentObject(model)
        }
        
    }
    
    private func addAction() {
        model.createNewJobPosting()
        isShowingSheet.toggle()
    }
    
}
