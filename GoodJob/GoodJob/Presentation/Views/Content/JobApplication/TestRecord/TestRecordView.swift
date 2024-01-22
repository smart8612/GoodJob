//
//  TestRecordView.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/22/24.
//

import SwiftUI

struct TestRecordView: View {
    
    @EnvironmentObject private var model: GJAppController
    
    let testId: UUID
    
    @State private var isShowingSheet: Bool = false
    
    var body: some View {
        DataContainer {
            List {
                Text("Hello World")
            }
            .navigationTitle("Test Memos")
        } sheet: { isShowingSheet in
            NewTestRecordView(
                isShowingSheet: $isShowingSheet,
                testId: testId
            )
        }
    }
    
}

struct NewTestRecordView: View {
    
    @EnvironmentObject private var model: GJAppController
    
    @State private var memo: String = .init()
    @Binding var isShowingSheet: Bool
    
    let testId: UUID
    
    var body: some View {
        DataCreationContainer(
            isShowingSheet: $isShowingSheet
        ) {
            List {
                TextEditor(text: $memo)
            }
            .navigationTitle("New Test Memo")
        }
        
    }
    
}


