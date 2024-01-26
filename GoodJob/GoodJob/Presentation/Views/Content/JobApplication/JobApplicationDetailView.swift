//
//  JobApplicationDetailView.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/21/24.
//

import SwiftUI


struct JobApplicationDetailView: View {
    
    @StateObject private var model = GJJobApplicationDetailViewModel()
    
    let selectedJobApplicationId: UUID?
    
    private var jobApplication: GJJobApplication? {
        model.jobApplication
    }
    
    private var jobPosting: GJJobPosting? {
        model.jobPosting
    }
    
    var body: some View {
        Group {
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
        .onAppear {
            model.selectedJobApplicationId = selectedJobApplicationId
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
                Text(jobApplication.createdAt.formatted())
            }
            
            Section {
                Text(jobPosting.companyName)
                Text(jobPosting.jobPositionName)
            }
            
            Section {
//                ForEach(jobPosting.tests) { test in
//                    NavigationLink(value: test) {
//                        VStack(alignment: .leading) {
//                            Text(test.type.description)
//                            Text(test.name)
//                        }
//                    }
//                }
            }
        }
        .navigationTitle("Job Application Detail")
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(for: GJTest.self) { test in
            TestRecordView(
                jobApplication: jobApplication,
                test: test
            )
        }
    }
    
}
