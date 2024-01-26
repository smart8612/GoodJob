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
    
    private var tests: [GJTest]? {
        model.tests
    }
    
    var body: some View {
        Group {
            if let jobApplication = jobApplication,
               let jobPosting = jobPosting,
               let tests = tests {
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
                        ForEach(tests) { test in
                            NavigationLink(value: test) {
                                VStack(alignment: .leading) {
                                    Text(test.type.description)
                                    Text(test.name)
                                }
                            }
                        }
                    }
                }
//                .navigationDestination(for: GJTest.self) { test in
//                    TestRecordView(
//                        jobApplication: jobApplication,
//                        test: test
//                    )
//                }
            } else {
                Text("Select a Job Application")
            }
        }
        .navigationTitle("Job Application Detail")
        .navigationBarTitleDisplayMode(.inline)
        .environmentObject(model)
        .onAppear {
            model.selectedJobApplicationId = selectedJobApplicationId
        }
    }
    
}
