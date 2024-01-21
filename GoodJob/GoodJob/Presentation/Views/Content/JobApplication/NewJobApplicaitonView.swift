//
//  NewJobApplicaitonView.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/20/24.
//

import SwiftUI

struct NewJobApplicaitonView: View {
    
    @EnvironmentObject private var model: GJAppController
    @Binding var isShowingSheet: Bool
    
    @State private var title: String = .init()
    @State private var selectedJobPosting: GJJobPosting? = nil
    
    var body: some View {
        DataCreationContainer(isShowingSheet: $isShowingSheet) {
            Form {
                Section {
                    TextField("Job Application Title", text: $title)
                }
                
                Section {
                    JobPostingSelectionView()
                }
            }
            .navigationTitle("New Job Application")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
}

struct JobPostingSelectionView: View {
    
    var body: some View {
        Text("Hello World")
    }
    
}
