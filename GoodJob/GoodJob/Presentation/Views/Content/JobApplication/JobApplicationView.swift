//
//  JobApplicationView.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/20/24.
//

import SwiftUI

struct JobApplicationView: View {
    
    @EnvironmentObject private var model: GoodJobManager
    
    var body: some View {
        
        DataContainer {
            List {
                
                ForEach(model.jobApplications) { jobApplication in
                    VStack(alignment: .leading) {
                        Text(jobApplication.title)
                        Text(jobApplication.id.uuidString)
                    }
                }
                
            }
            .listStyle(.insetGrouped)
        } sheet: { isShowingSheet in
            Text("This is JobApplication creating view")
        }
        
    }
    
}
