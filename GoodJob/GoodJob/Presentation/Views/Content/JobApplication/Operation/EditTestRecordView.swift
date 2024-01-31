//
//  EditTestRecordView.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/31/24.
//

import SwiftUI


struct EditTestRecordView: View {
    
    @EnvironmentObject private var model: GJJobApplicationDetailViewModel
    
    @Binding var isShowingSheet: Bool
    @State var testRecord: GJTestRecord
    
    var body: some View {
        DataCreationContainer(
            isShowingSheet: $isShowingSheet,
            addAction: addAction
        ) {
            TestRecordOperationView(testRecord: $testRecord)
                .navigationTitle("Edit Test Record")
        }
    }
    
    private func addAction() {
        model.update(testRecord: testRecord)
        isShowingSheet.toggle()
    }
    
}
