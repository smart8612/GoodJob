//
//  DataContainer.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/20/24.
//

import SwiftUI


struct DataContainer<Content: View, Sheet: View>: View {
    
    @State private var isShowingSheet = false
    
    let content: () -> Content
    let sheet: (Binding<Bool>) -> Sheet
    
    init(@ViewBuilder content: @escaping () -> Content, sheet: @escaping (Binding<Bool>) -> Sheet) {
        self.content = content
        self.sheet = sheet
    }
    
    var body: some View {
        content()
            .toolbar {
                ToolbarItem {
                    EditButton()
                }
                
                ToolbarItem {
                    Button(action: { isShowingSheet.toggle() }) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $isShowingSheet) {
                sheet($isShowingSheet)
            }
    }
    
}
