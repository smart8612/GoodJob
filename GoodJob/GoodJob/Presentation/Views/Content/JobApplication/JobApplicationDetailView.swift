//
//  JobApplicationDetailView.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/21/24.
//

import SwiftUI


struct JobApplicationDetailView: View {
    
    @StateObject var model: GJJobApplicationDetailViewModel
    
    private var selectedJobApplicationId: UUID? {
        model.selectedJobApplicationId
    }
    
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
            } else {
                Text("Select a Job Application")
            }
        }
        .navigationTitle("Job Application Detail")
        .navigationBarTitleDisplayMode(.inline)
        .environmentObject(model)
        .onAppear {
            model.fetchJobApplication()
        }
    }
    
}
