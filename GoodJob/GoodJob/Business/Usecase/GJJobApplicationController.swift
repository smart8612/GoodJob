//
//  GJJobApplicationController.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/20/24.
//

import Foundation


final class GJJobApplicationController {
    
    private let jobApplicationRepository: any GJRepository<GJJobApplication>
    private let jobPostingRepository: any GJRepository<GJJobPosting>
    private var userSessionController: GJUserSessionController { .shared }
    
    init(jobApplicationRepository: any GJRepository<GJJobApplication>,
         jobPostingRepository: any GJRepository<GJJobPosting>) {
        self.jobApplicationRepository = jobApplicationRepository
        self.jobPostingRepository = jobPostingRepository
    }
    
    func fetchRegistableJobPostings() throws -> [GJJobPosting]  {
        try jobPostingRepository.fetchAll()
            .filter { $0.jobApplicationId == nil }
    }
    
    func fetchAllJobApplications() throws -> [GJJobApplication] {
        let jobApplicationIds = Array(userSessionController.currentUser?.jobApplicationIds ?? .init())
        let fetchedJobApplications = try jobApplicationRepository.fetch(objectsWith: jobApplicationIds)
        return fetchedJobApplications
    }
    
    func create(jobApplication: GJJobApplication) throws -> GJJobApplication {
        guard let userId = userSessionController.currentUser?.id else {
            throw GJJobApplicationController.currentUserNotFound
        }
        
        let createdJobApplication = try jobApplicationRepository.create(object: .init(
            title: jobApplication.title,
            jobPostingId: jobApplication.jobPostingId,
            userId: userId
        ))
        
        return createdJobApplication
    }
    
    enum GJJobApplicationController: Error {
        case currentUserNotFound
    }
    
}
