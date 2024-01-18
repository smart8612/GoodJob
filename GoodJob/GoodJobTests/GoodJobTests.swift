//
//  GoodJobTests.swift
//  GoodJobTests
//
//  Created by JeongTaek Han on 1/15/24.
//

import XCTest
@testable import GoodJob


final class GoodJobTests: XCTestCase {
    
    private var persistenceController: PersistenceController!
    private var model: GoodJobManager!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        persistenceController = PersistenceController(inMemory: true)
        model = GoodJobManager(persistenceController: persistenceController)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        persistenceController = nil
        model = nil
    }

    func test_JobPosting_신규_생성_검증() throws {
        // Given
        let newJobPosting = GJJobPosting(
            companyName: "Apple",
            jobPositionName: "iOS Developer",
            workplaceLocation: "USA",
            recruitNumbers: "10",
            link: "https://www.apple.com",
            startDate: .now,
            endDate: Date(timeInterval: 259200, since: .now)
        )
        
        // When
        let createdJobPosting = model.create(jobPosting: newJobPosting)
        
        // Then
        XCTAssertTrue(
            createdJobPosting.companyName == newJobPosting.companyName &&
            createdJobPosting.jobPositionName == newJobPosting.jobPositionName &&
            createdJobPosting.workplaceLocation == newJobPosting.workplaceLocation &&
            createdJobPosting.recruitNumbers == newJobPosting.recruitNumbers &&
            createdJobPosting.link == newJobPosting.link &&
            createdJobPosting.startDate == newJobPosting.startDate &&
            createdJobPosting.endDate == newJobPosting.endDate
        )
    }
    
    func test_특정_ID를_가진_JobPosting_fetch_검증() throws {
        // Given
        let newJobPosting = GJJobPosting(
            companyName: "Apple",
            jobPositionName: "iOS Developer",
            workplaceLocation: "USA",
            recruitNumbers: "10",
            link: "https://www.apple.com",
            startDate: .now,
            endDate: Date(timeInterval: 259200, since: .now)
        )
        
        // When
        let createdJobPosting = model.create(jobPosting: newJobPosting)
        guard let result = model.fetchJobPostings(ids: [createdJobPosting.id]).first else {
            XCTFail()
            return
        }
        
        // Then
        XCTAssertTrue(
            result.companyName == newJobPosting.companyName &&
            result.jobPositionName == newJobPosting.jobPositionName &&
            result.workplaceLocation == newJobPosting.workplaceLocation &&
            result.recruitNumbers == newJobPosting.recruitNumbers &&
            result.link == newJobPosting.link &&
            result.startDate == newJobPosting.startDate &&
            result.endDate == newJobPosting.endDate
        )
    }
    
    func test_JobPosting_제거_검증() throws {
        // Given
        let newJobPosting = GJJobPosting(
            companyName: "Apple",
            jobPositionName: "iOS Developer",
            workplaceLocation: "USA",
            recruitNumbers: "10",
            link: "https://www.apple.com",
            startDate: .now,
            endDate: Date(timeInterval: 259200, since: .now)
        )
        
        // When
        let createdJobPosting = model.create(jobPosting: newJobPosting)
        model.deleteJobPostings(on: .init(integer: .zero))
        
        // Then
        let result = model.jobPostings
        XCTAssertTrue(result.count == 0)
    }
    
    func test_채용시험정보_Test_포함_JobPosting_생성_검증() {
        XCTFail()
    }

}
