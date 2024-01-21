//
//  JobApplicationsListView.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/20/24.
//

import SwiftUI

struct JobApplicationsListView: View {
    
    @EnvironmentObject private var model: GJAppController
    
    var body: some View {
        
        DataContainer {
            List {
                ForEach(model.jobApplications) { jobApplication in
                    NavigationLink {
                        JobApplicationDetailView(jobApplicationId: jobApplication.id)
                    } label: {
                        JobApplicationCellView(
                            jobApplication: jobApplication
                        )
                    }
                }
            }
            .listStyle(.insetGrouped)
        } sheet: { isShowingSheet in
            NewJobApplicaitonView(isShowingSheet: isShowingSheet)
        }
        
    }
    
}
