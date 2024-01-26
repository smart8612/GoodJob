//
//  GoodJobPostingTests.swift
//  GoodJobTests
//
//  Created by JeongTaek Han on 1/23/24.
//

import XCTest
@testable import GoodJob


final class GoodJobPostingTests: XCTestCase {
    
    private var testRepository: (any GJRepository<GJTest>)!
    private var jobPostingRepository: (any GJRepository<GJJobPosting>)!
    private var jobPostingController: GJJobPostingController!

    override func setUpWithError() throws {
        let persistenceController = PersistenceController(inMemory: true)
        self.testRepository = GJTestRepository(
            persistenceController: persistenceController
        )
        self.jobPostingRepository = GJJobPostingRepository(
            persistenceController: persistenceController
        )
        self.jobPostingController = GJJobPostingController(
            jobPostingRepository: jobPostingRepository,
            testRepository: testRepository
        )
    }

    override func tearDownWithError() throws {
        self.testRepository = nil
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

    func test_채용시험_Test_포함_JobPosting_생성_검증() throws {
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
        let newTests = [
            GJTest(order: 0, name: "first written test", type: .writtenTest, jobPostingId: createdJobPosting.id),
            GJTest(order: 1, name: "second meeting interview test", type: .inteview, jobPostingId: createdJobPosting.id)
        ]
        
        // When
        let createdTests = newTests.compactMap { try? testRepository.create(object: $0) }
        let fetchedJobPostings = try jobPostingRepository.fetch(objectsWith: [createdJobPosting.id])
        guard let fetchedJobPosting = fetchedJobPostings.first else {
            XCTFail()
            return
        }
        let fetchedTests = try testRepository.fetch(objectsWith: Array(fetchedJobPosting.testIds))
        
        // Then
        XCTAssertTrue(
            fetchedTests[0] == createdTests[0] &&
            fetchedTests[1] == createdTests[1] &&
            fetchedTests[0].name == newTests[0].name &&
            fetchedTests[0].type == newTests[0].type &&
            fetchedTests[1].name == newTests[1].name &&
            fetchedTests[1].type == newTests[1].type
        )

    }
    
}
