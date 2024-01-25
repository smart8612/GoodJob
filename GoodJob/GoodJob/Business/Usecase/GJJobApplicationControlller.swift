//
//  GJJobApplicationControlller.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/20/24.
//

import Foundation


final class GJJobApplicationControlller {
    
    private let jobApplicationRepository: any GJRepository<GJJobApplication>
    private var userSessionController: GJUserSessionController { .shared }
    
    init(jobApplicationRepository: any GJRepository<GJJobApplication>) {
        self.jobApplicationRepository = jobApplicationRepository
    }
    
//    func create(jobApplication: GJJobApplication) -> GJJobApplication {
//        return jobApplicationController.create(jobApplication: jobApplication, userId: currentUser!.id)
//    }
//    
//    func fetchJobApplications(ids: [UUID]) -> [GJJobApplication] {
//        return jobApplicationController.fetchJobApplications(ids: ids)
//    }
    
    func fetchAllJobApplications() throws -> [GJJobApplication] {
        let jobApplicationIds = Array(userSessionController.currentUser?.jobApplicationIds ?? .init())
        let fetchedJobApplications = try jobApplicationRepository.fetch(objectsWith: jobApplicationIds)
        return fetchedJobApplications
    }
    
//    func fetchJobApplicationRegistableJobPostings() -> [GJJobPosting]  {
//        return .init()
//    }
    
}
