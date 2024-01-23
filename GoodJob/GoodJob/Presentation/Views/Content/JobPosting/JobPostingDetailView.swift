//
//  JobPostingDetailView.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/19/24.
//

import SwiftUI


struct JobPostingDetailView: View {
    
    @EnvironmentObject private var model: GJAppController
    
    let selectedJobPostingId: UUID?
    
    private var jobPosting: GJJobPosting? {
        guard let selectedJobPostingId = selectedJobPostingId else {
            return nil
        }
        
        let fetchedJobPostings = model.fetchJobPostings(
            ids: [selectedJobPostingId]
        )
        
        return fetchedJobPostings.first
    }
    
    var body: some View {
        if let jobPosting = jobPosting {
            JobPostingDetailListView(jobPosting: jobPosting)
        } else {
            Text("Select a Job Posting")
        }
    }
    
}

fileprivate struct JobPostingDetailListView: View {
    
    let jobPosting: GJJobPosting
    
    var body: some View {
        
        List {
            Section {
                Text("Company Name: \(jobPosting.companyName)")
            }
            
            Section {
                Text("Job Position: \(jobPosting.jobPositionName)")
                Text("Workplace Location: \(jobPosting.workplaceLocation)")
                Text("Recruitment Numbers: \(jobPosting.recruitNumbers)")
                Text("Job Posting Link: \(jobPosting.link)")
            }
            
            Section {
                Text("Starts: \(jobPosting.startDate.formatted())")
                Text("Ends: \(jobPosting.endDate.formatted())")
            }
            
            Section {
//                ForEach(jobPosting.tests) { test in
//                    HStack {
//                        Text(test.type.description)
//                        Divider()
//                        Text(test.name)
//                    }
//                }
            }
        }
        .navigationTitle("Jobs Details")
        .navigationBarTitleDisplayMode(.inline)
        
    }
}
