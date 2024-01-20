//
//  NewJobApplicaitonView.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/20/24.
//

import SwiftUI

struct NewJobApplicaitonView: View {
    
    @Binding var isShowingSheet: Bool
    
    @State private var title: String = .init()
    
    var body: some View {
        DataCreationContainer(isShowingSheet: $isShowingSheet) {
            Form {
                Section {
                    TextField("Job Application Title", text: $title)
                }
            }
            .navigationTitle("New Job Application")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
}
