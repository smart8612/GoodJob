//
//  JobApplicationDetailView.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/21/24.
//

import SwiftUI


//struct JobApplicationDetailView: View {
//    
//    @EnvironmentObject private var model: GJAppController
//    
//    let selectedJobApplicationId: UUID?
//    
//    private var jobApplication: GJJobApplication? {
//        guard let selectedJobApplicationId = selectedJobApplicationId else {
//            return nil
//        }
//        
//        let fetchedJobApplications = model.fetchJobApplications(
//            ids: [selectedJobApplicationId]
//        )
//        
//        return fetchedJobApplications.first
//    }
//    
//    private var jobPosting: GJJobPosting? {
//        guard let jobApplication = jobApplication else {
//            return nil
//        }
//        
//        let fetchedJobPostings = model.fetchJobPostings(
//            ids: [jobApplication.jobPostingId]
//        )
//        
//        return fetchedJobPostings.first
//    }
//    
//    var body: some View {
//        
//        if let jobApplication = jobApplication,
//           let jobPosting = jobPosting {
//            JobApplicationDetailListView(
//                jobApplication: jobApplication,
//                jobPosting: jobPosting
//            )
//        } else {
//            Text("Select a Job Application")
//        }
//        
//    }
//    
//}

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
