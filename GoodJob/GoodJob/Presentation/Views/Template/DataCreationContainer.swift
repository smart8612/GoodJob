//
//  DataCreationContainer.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/20/24.
//

import SwiftUI


struct DataCreationContainer<Content: View>: View {
    
    @State private var isShowingConfirmationDialog = false
    
    let isShowingSheet: Binding<Bool>
    let content: () -> Content
    let addAction: (() -> Void)?
    let cancelAction: (() -> Void)?
    
    init(isShowingSheet: Binding<Bool>,
         addAction: (() -> Void)? = nil,
         cancelAction: (() -> Void)? = nil,
         @ViewBuilder content: @escaping () -> Content) {
        self.content = content
        self.isShowingSheet = isShowingSheet
        self.addAction = addAction
        self.cancelAction = cancelAction
    }

    var body: some View {
        NavigationStack {
            content()
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Cancel") {
                            isShowingConfirmationDialog = true
                        }
                        .confirmationDialog(
                            "Are you sure want to discard?",
                            isPresented: $isShowingConfirmationDialog,
                            titleVisibility: .visible
                        ) {
                            Button("Discard Changes", role: .destructive) {
                                isShowingSheet.wrappedValue.toggle()
                            }
                            Button("Keep Editing", role: .cancel) {
                                isShowingConfirmationDialog = false
                            }
                        }
                        
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Save", action: { addAction?() })
                    }
                }
        }
        
    }
    
}
