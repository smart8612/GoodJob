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

    func test_JobPosting이_생성_검증() throws {
        // Given
        let newJobPosting = GJJobPosting(
            companyName: "Apple",
            jobPostitionName: "iOS Developer",
            workplaceLocation: "USA",
            recruitNumbers: "10",
            link: "https://www.apple.com",
            startDate: .now,
            endDate: Date(timeInterval: 259200, since: .now)
        )
        
        // when
        model.create(jobPosting: newJobPosting)
        
        // then
        let result = model.jobPostings
        print(result)
        
        XCTAssertTrue(result.count == 1)
    }

}
