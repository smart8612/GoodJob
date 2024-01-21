//
//  MainSplitView.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/15/24.
//

import SwiftUI


struct MainSplitView: View {
    
    @StateObject private var navigationModel = GJNavigationModel()

    var body: some View {
        
        NavigationSplitView(
            columnVisibility: $navigationModel.columnVisibility
        ) {
            SidebarListView()
        } content: {
            ContentView()
        } detail: {
            DetailView()
        }
        .navigationSplitViewStyle(.balanced)
        .environmentObject(navigationModel)

    }

}


#Preview {
    MainSplitView()
        .environmentObject(GJAppController.initWithPreview())
}
