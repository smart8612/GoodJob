//
//  GJNewJobApplicationViewModel.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/25/24.
//

import Foundation


final class GJNewJobApplicationViewModel: ObservableObject {
    
    @Published var title: String = .init()
    @Published var selectedJobPosting: GJJobPosting? = nil
    
    private let jobApplicationController: GJJobApplicationController = {
        GJJobApplicationController(
            testRecordRepository: GJTestRecordRepository(), 
            jobApplicationRepository: GJJobApplicationRepository(),
            jobPostingRepository: GJJobPostingRepository()
        )
    }()
    
    var registableJobPostings: [GJJobPosting] {
        (try? jobApplicationController.fetchRegistableJobPostings()) ?? .init()
    }
    
    func createJobApplication() {
        guard let selectedJobPosting = selectedJobPosting else {
            return
        }
        
        do {
            let _ = try jobApplicationController.create(jobApplication: .init(
                title: title,
                jobPostingId: selectedJobPosting.id,
                userId: .init()
            ))
        } catch {
            print(error)
        }
    }
    
}
