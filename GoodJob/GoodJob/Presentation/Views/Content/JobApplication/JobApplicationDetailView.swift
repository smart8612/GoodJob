//
//  JobApplicationDetailView.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/21/24.
//

import SwiftUI

struct JobApplicationDetailView: View {
    
    @EnvironmentObject private var model: GJAppController
    
    let jobApplicationId: UUID
    @State private var jobApplication: GJJobApplication = .initWithEmpty()
    @State private var jobPosting: GJJobPosting = .initWithEmpty()
    
    var body: some View {
        Form {
            Section {
                Text(jobApplication.title)
            }
            
            Section {
                NavigationLink {
                    JobPostingDetailView(
                        jobPostingId: jobApplication.jobPostingId
                    )
                } label: {
                    Text("JobPosting \(jobPosting.jobPositionName) @ \(jobPosting.companyName)")
                }

            }
        }
        .onAppear(perform: fetchJobApplication)
    }
    
    private func fetchJobApplication() {
        jobApplication = model.fetchJobApplications(
            ids: [jobApplicationId]
        ).first ?? .initWithEmpty()
        
        jobPosting = model.fetchJobPostings(
            ids: [jobApplication.jobPostingId]
        ).first ?? .initWithEmpty()
    }
    
}
