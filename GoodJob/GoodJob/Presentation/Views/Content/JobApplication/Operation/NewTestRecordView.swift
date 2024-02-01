//
//  NewTestRecordView.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/31/24.
//

import SwiftUI


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
            TestRecordOperationView(testRecord: $testRecord)
                .navigationTitle("New Test Record")
        }
    }
    
    private func addAction() {
        model.create(testRecord: testRecord, belongsTo: test)
        isShowingSheet.toggle()
    }
    
}
