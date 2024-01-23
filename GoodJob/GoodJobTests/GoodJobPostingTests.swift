//
//  GoodJobPostingTests.swift
//  GoodJobTests
//
//  Created by JeongTaek Han on 1/23/24.
//

import XCTest
@testable import GoodJob


final class GoodJobPostingTests: XCTestCase {
    
    private var jobPostingRepository: (any GJRepository<GJJobPosting>)!
    private var jobPostingController: GJJobPostingControlller!

    override func setUpWithError() throws {
        self.jobPostingRepository = GJJobPostingRepository(
            persistenceController: .init(inMemory: true)
        )
        self.jobPostingController = GJJobPostingControlller(
            jobPostingRepository: jobPostingRepository
        )
    }

    override func tearDownWithError() throws {
        self.jobPostingRepository = nil
        self.jobPostingController = nil
    }

    func test_JobPosting_신규_생성_검증() throws {
        // Given
        let newJobPosting = GJJobPosting(
            link: "https://www.apple.com",
            companyName: "Apple",
            jobPositionName: "iOS Developer",
            workplaceLocation: "USA",
            recruitNumbers: "10",
            startDate: .now,
            endDate: Date(timeInterval: 259200, since: .now),
            testIds: .init()
        )
        
        // When
        let createdJobPosting = try jobPostingRepository.create(object: newJobPosting)
        
        // Then
        XCTAssertTrue(
            createdJobPosting.link == newJobPosting.link &&
            createdJobPosting.companyName == newJobPosting.companyName &&
            createdJobPosting.jobPositionName == newJobPosting.jobPositionName &&
            createdJobPosting.workplaceLocation == newJobPosting.workplaceLocation &&
            createdJobPosting.recruitNumbers == newJobPosting.recruitNumbers &&
            createdJobPosting.startDate == newJobPosting.startDate &&
            createdJobPosting.endDate == newJobPosting.endDate &&
            createdJobPosting.testIds == newJobPosting.testIds &&
            createdJobPosting.jobApplicationId == newJobPosting.jobApplicationId
        )
    }
    
    func test_특정_ID를_가진_JobPosting_fetch_검증() throws {
        // Given
        let newJobPosting = GJJobPosting(
            link: "https://www.apple.com",
            companyName: "Apple",
            jobPositionName: "iOS Developer",
            workplaceLocation: "USA",
            recruitNumbers: "10",
            startDate: .now,
            endDate: Date(timeInterval: 259200, since: .now),
            testIds: .init()
        )
        
        // When
        let createdJobPosting = try jobPostingRepository.create(object: newJobPosting)
        let fetchedJobPostings = try jobPostingRepository.fetch(objectsWith: [createdJobPosting.id])
        guard let fetchedJobPosting = fetchedJobPostings.first else {
            XCTFail()
            return
        }
        
        // Then
        XCTAssertTrue(fetchedJobPosting == createdJobPosting)
    }

    func test_JobPosting_제거_검증() throws {
        // Given
        let newJobPosting = GJJobPosting(
            link: "https://www.apple.com",
            companyName: "Apple",
            jobPositionName: "iOS Developer",
            workplaceLocation: "USA",
            recruitNumbers: "10",
            startDate: .now,
            endDate: Date(timeInterval: 259200, since: .now),
            testIds: .init()
        )
        let createdJobPosting = try jobPostingRepository.create(object: newJobPosting)
        let fetchedJobPostings = try jobPostingRepository.fetch(objectsWith: [createdJobPosting.id])
        guard let fetchedJobPosting = fetchedJobPostings.first else {
            XCTFail()
            return
        }
        
        // When
        try jobPostingRepository.delete(objectWith: fetchedJobPosting.id)

        // Then
        let results = try jobPostingRepository.fetch(objectsWith: [fetchedJobPosting.id])
        XCTAssertTrue(results.isEmpty)
    }
    
    

}
