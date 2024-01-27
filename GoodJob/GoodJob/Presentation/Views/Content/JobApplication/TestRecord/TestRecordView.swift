//
//  TestRecordView.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/22/24.
//

import SwiftUI


struct TestRecordView: View {
    
    @State private var testRecords: [GJTestRecord] = .init()
    
    var body: some View {
        DataContainer {
            List {
                Section {
                    Text(test.type.description)
                    Text(test.name)
                }
                
                Section {
                    ForEach(testRecords) {
                        Text($0.memo)
                    }
                }
            }
        } sheet: { isShowingSheet in
//            NewTestRecordView(
//                isShowingSheet: isShowingSheet,
//                jobApplication: jobApplication,
//                test: test
//            )
            Text("Hello World")
        }
        .navigationTitle("Test Memos")
        .navigationBarTitleDisplayMode(.inline)
    }
    
}

//struct NewTestRecordView: View {
//    
//    @EnvironmentObject private var model: GJAppController
//    
//    @State private var memo: String = .init()
//    @Binding var isShowingSheet: Bool
//    
//    let jobApplication: GJJobApplication
//    let test: GJTest
//    
//    private var jobApplicationId: UUID {
//        jobApplication.id
//    }
//    
//    private var testId: UUID {
//        test.id
//    }
//    
//    private var testRecord: GJTestRecord {
//        .init(
//            jobApplicationId: jobApplicationId,
//            testId: testId,
//            memo: memo
//        )
//    }
//    
//    var body: some View {
//        DataCreationContainer(
//            isShowingSheet: $isShowingSheet,
//            addAction: addAction
//        ) {
//            List {
//                TextEditor(text: $memo)
//            }
//            .navigationTitle("New Test Memo")
//        }
//        
//    }
//    
//    private func addAction() {
//        //let _ = model.create(testRecord: testRecord)
//        isShowingSheet.toggle()
//    }
//    
//}
//
//
