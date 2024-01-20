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
        List {
            
            ForEach(model.jobApplications) { jobApplication in
                VStack(alignment: .leading) {
                    Text(jobApplication.title)
                    Text(jobApplication.id.uuidString)
                }
            }
            
        }
        
    }
    
}

#Preview {
    JobApplicationView()
        .environmentObject(
            GoodJobManager.initWithPreview()
        )
}
