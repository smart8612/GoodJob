//
//  GJJobPostingController.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/17/24.
//

import Foundation


final class GJJobPostingController {
    
    private let jobPostingRepository: any GJRepository<GJJobPosting>
    private let testRepository: any GJRepository<GJTest>
    
    init(
        jobPostingRepository: any GJRepository<GJJobPosting>,
        testRepository: any GJRepository<GJTest>
    ) {
        self.jobPostingRepository = jobPostingRepository
        self.testRepository = testRepository
    }
    
    func fetchAllJobPostings() throws -> [GJJobPosting] {
        try jobPostingRepository.fetchAll()
    }
    
    func fetchJobPostings(ids: [UUID]) throws -> [GJJobPosting] {
        try jobPostingRepository.fetch(objectsWith: ids)
    }
    
    func fetchJobPosting(with id: UUID) throws -> GJJobPosting {
        let fetchedJobPostings = try jobPostingRepository.fetch(objectsWith: [id])
        guard let fetchedJobPositng = fetchedJobPostings.first else {
            throw GJJobPostingControllerError.jobPostingNotFound
        }
        return fetchedJobPositng
    }
    
    func fetchJobApplicationRegistableJobPostings() throws -> [GJJobPosting] {
        let jobPostings = try jobPostingRepository.fetchAll()
        return jobPostings.filter { $0.jobApplicationId == nil }
    }
    
    func fetchTests(belongsToJobPosting id: UUID) throws -> [GJTest] {
        let fetchedJobPosting = try fetchJobPosting(with: id)
        let targetTestIds = Array(fetchedJobPosting.testIds)
        let fetchedTests = try testRepository.fetch(objectsWith: targetTestIds)
        return fetchedTests
    }
    
    func create(jobPosting: GJJobPosting, tests: [GJTest]) throws -> GJJobPosting {
        let createdJobPosting = try jobPostingRepository.create(object: jobPosting)
        let createdTests = try tests
            .map {
                var test = $0
                test.jobPostingId = createdJobPosting.id
                return test
            }
            .map { try testRepository.create(object: $0) }
        
        let fetchedResults = try jobPostingRepository.fetch(
            objectsWith: [createdJobPosting.id]
        )
        
        guard let fetchedResult = fetchedResults.first else {
            throw GJJobPostingControllerError.jobPostingCreationFail
        }
        
        return fetchedResult
    }
    
    func update(jobPosting: GJJobPosting, tests: [GJTest]) throws -> GJJobPosting {
        let targetTests = Array(tests.enumerated()).map { index, test in
            var newTest = test
            newTest.jobPostingId = jobPosting.id
            newTest.order = index
            return newTest
        }
        
        let testIdSet = Set(targetTests.map { $0.id })
        let targetTestSet = Set(targetTests)
        
        let createRequiredTestIds = testIdSet.subtracting(jobPosting.testIds)
        try targetTestSet
            .filter { createRequiredTestIds.contains($0.id) }
            .forEach { try testRepository.create(object: $0) }
        
        let updateRequiredTestIds = testIdSet.intersection(jobPosting.testIds)
        try targetTestSet
            .filter { updateRequiredTestIds.contains($0.id) }
            .forEach { try testRepository.update(objectWith: $0.id, to: $0) }
        
        let deleteRequiredTestIds = jobPosting.testIds.subtracting(testIdSet)
        try deleteRequiredTestIds
            .forEach { try testRepository.delete(objectWith: $0) }
        
        let updatedJobPosting = try jobPostingRepository.update(objectWith: jobPosting.id, to: jobPosting)
        return updatedJobPosting
    }
    
    func deleteJobPosting(id: UUID) throws {
        try jobPostingRepository.delete(objectWith: id)
    }
    
    enum GJJobPostingControllerError: Error {
        case jobPostingCreationFail
        case jobPostingNotFound
    }
    
}
