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
        model.create(jobPosting: newJobPosting)
        
        // Then
        guard let result = model.jobPostings.first else {
            XCTFail()
            return
        }
        
        print(result)
        
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
    
    /*
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
        model.create(jobPosting: newJobPosting)
        model.deleteJobPostings(on: )
        
        // Then
        let result = model.jobPostings
        print(result)
        
        XCTAssertTrue(result.count == 1)
    }
     */

}
