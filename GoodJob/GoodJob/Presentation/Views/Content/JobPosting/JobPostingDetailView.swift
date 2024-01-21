//
//  JobPostingDetailView.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/19/24.
//

import SwiftUI

struct JobPostingDetailView: View {
    
    @EnvironmentObject private var model: GJAppController
    
    let jobPostingId: UUID
    @State private var jobPosting: GJJobPosting = .initWithEmpty()
    
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
                Text("Starts: \(jobPosting.startDate)")
                Text("Ends: \(jobPosting.endDate)")
            }
            
            Section {
                ForEach(jobPosting.tests) { test in
                    HStack {
                        Text(test.type.description)
                        Divider()
                        Text(test.name)
                    }
                }
            }
        }
        .navigationTitle(jobPosting.jobPositionName)
        .onAppear {
            fetchJobPosting()
        }
    }
    
    private func fetchJobPosting() {
        self.jobPosting = model.fetchJobPostings(
            ids: [jobPostingId]
        ).first ?? .initWithEmpty()
    }
    
}
