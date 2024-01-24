//
//  GJJobPostingControlller.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/17/24.
//

import Foundation


final class GJJobPostingControlller {
    
    private let jobPostingRepository: any GJRepository<GJJobPosting>
    
    init(jobPostingRepository: any GJRepository<GJJobPosting>) {
        self.jobPostingRepository = jobPostingRepository
    }
    
    func fetchAllJobPostings() throws -> [GJJobPosting] {
        try jobPostingRepository.fetchAll()
    }
    
    func fetchJobPostings(ids: [UUID]) throws -> [GJJobPosting] {
        try jobPostingRepository.fetch(objectsWith: ids)
    }
    
    func fetchJobApplicationRegistableJobPostings() throws -> [GJJobPosting] {
        let jobPostings = try jobPostingRepository.fetchAll()
        return jobPostings.filter { $0.jobApplicationId == nil }
    }
    
    func create(jobPosting: GJJobPosting) throws -> GJJobPosting {
        try jobPostingRepository.create(object: jobPosting)
    }
    
    func updateJobPosting(id: UUID, to object: GJJobPosting) throws -> GJJobPosting {
        try jobPostingRepository.update(objectWith: id, to: object)
    }
    
    func deleteJobPosting(id: UUID) throws {
        try jobPostingRepository.delete(objectWith: id)
    }
    
}
