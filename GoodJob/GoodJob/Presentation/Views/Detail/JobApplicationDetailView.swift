//
//  JobApplicationDetailView.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/21/24.
//

import SwiftUI

struct JobApplicationDetailView: View {
    
    @EnvironmentObject private var model: GJAppController
    @EnvironmentObject private var navigationModel: GJNavigationModel
    
    private var selectedJobApplicationId: UUID? {
        navigationModel.selectedJobApplication?.id
    }
    
    private var jobApplication: GJJobApplication? {
        guard let selectedJobApplicationId = selectedJobApplicationId else {
            return nil
        }
        
        let fetchedJobApplications = model.fetchJobApplications(
            ids: [selectedJobApplicationId]
        )
        
        return fetchedJobApplications.first
    }
    
    private var jobPosting: GJJobPosting? {
        guard let jobApplication = jobApplication else {
            return nil
        }
        
        let fetchedJobPostings = model.fetchJobPostings(
            ids: [jobApplication.jobPostingId]
        )
        
        return fetchedJobPostings.first
    }
    
    var body: some View {
        
        if let jobApplication = jobApplication,
           let jobPosting = jobPosting {
            JobApplicationDetailListView(
                jobApplication: jobApplication,
                jobPosting: jobPosting
            )
        } else {
            Text("Select a Job Application")
        }
        
    }
    
}

fileprivate struct JobApplicationDetailListView: View {
    
    let jobApplication: GJJobApplication
    let jobPosting: GJJobPosting
    
    var body: some View {
        List {
            Section {
                Text(jobApplication.title)
            }
            
            Section {
                Text("JobPosting \(jobPosting.jobPositionName) @ \(jobPosting.companyName)")
            }
        }
    }
    
}
