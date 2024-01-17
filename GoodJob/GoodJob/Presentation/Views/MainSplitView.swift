//
//  MainSplitView.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/15/24.
//

import SwiftUI


struct MainSplitView: View {
    
    @State private var selectedCategory: Category? = .summary
    @State private var columnVisibility: NavigationSplitViewVisibility = .all

    var body: some View {
        
        NavigationSplitView(columnVisibility: $columnVisibility) {
            SidebarListView(
                selectedCategory: $selectedCategory
            )
        } content: {
            ContentView(
                selectedCategory: $selectedCategory
            )
        } detail: {
            Text("Hello World")
        }
        .navigationSplitViewStyle(.balanced)

    }

}

#Preview {
    MainSplitView()
        .environment(\.managedObjectContext,
                      PersistenceController.preview.container.viewContext)
}
