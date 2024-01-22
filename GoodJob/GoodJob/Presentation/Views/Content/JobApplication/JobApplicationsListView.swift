//
//  JobApplicationsListView.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/20/24.
//

import SwiftUI

struct JobApplicationsListView: View {
    
    @EnvironmentObject private var model: GJAppController
    @EnvironmentObject private var navigationModel: GJNavigationModel
    
    var body: some View {
        NavigationStack {
            DataContainer {
                List(selection: $navigationModel.selectedJobApplication) {
                    ForEach(model.jobApplications) { jobApplication in
                        NavigationLink(value: jobApplication) {
                            JobApplicationCellView(
                                jobApplication: jobApplication
                            )
                        }
                    }
                }
            } sheet: { isShowingSheet in
                NewJobApplicaitonView(isShowingSheet: isShowingSheet)
            }
        }
    }
    
}
