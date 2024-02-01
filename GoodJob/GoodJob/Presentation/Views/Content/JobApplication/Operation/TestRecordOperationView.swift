//
//  TestRecordOperationView.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/31/24.
//

import SwiftUI


struct TestRecordOperationView: View {
    
    @Binding var testRecord: GJTestRecord
    
    var body: some View {
        List {
            Section("Memo") {
                TextEditor(text: $testRecord.memo)
            }
            
            Section("Status") {
                Menu(testRecord.result.description) {
                    ForEach(GJTestRecord.TestResult.allCases) { resultType in
                        Button(action: { testRecord.result = resultType }) {
                            Text(resultType.description)
                        }
                    }
                }
            }
        }
    }
    
}
