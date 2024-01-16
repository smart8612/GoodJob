//
//  NewJobPostingView.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/15/24.
//

import SwiftUI


struct NewJobPostingView: View {
    
    @Binding var isPresentingNewJobPosting: Bool
    @State private var isShowingConfirmationlDialog = false
    
    private let title = "Are you sure want to discard this new job posting?"
    
    var body: some View {
        NavigationStack {
            List {
                Text("Hello World")
            }
            .navigationTitle("Hello World")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        isShowingConfirmationlDialog = true
                        print("Cancel Button Clicked")
                    }
                    .confirmationDialog(
                        title,
                        isPresented: $isShowingConfirmationlDialog,
                        titleVisibility: .visible
                    ) {
                        Button("Discard Changes", role: .destructive) {
                            isPresentingNewJobPosting = false
                        }
                        Button("Keep Editing", role: .cancel) {
                            isShowingConfirmationlDialog = false
                        }
                    }
                    
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add") {
                        print("Add Button Clicked")
                    }
                }
            }
        }
        
    }
    
}
