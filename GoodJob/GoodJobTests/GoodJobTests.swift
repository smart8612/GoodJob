//
//  GoodJobTests.swift
//  GoodJobTests
//
//  Created by JeongTaek Han on 1/15/24.
//

import XCTest
@testable import GoodJob


final class GoodJobTests: XCTestCase {
    
    // 지금은 데이터 모델 관계 제약이 정상적으로 동작하는지만 본다.
    private var persistenceController: GoodJob.PersistenceController!
    private var jobPostingManager: GoodJob.JobPostingViewModel!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        persistenceController = GoodJob.PersistenceController(inMemory: true)
        jobPostingManager = GoodJob.JobPostingViewModel(persistenceController: persistenceController)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        persistenceController = nil
        jobPostingManager = nil
    }

    func test_JobPosting_더미_데이터가_생성되는가() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        
        // Create Dummy Data
        jobPostingManager.createJobPosting { (postData: GoodJob.JobPosting) in
            postData.company?.name = "Apple"
            postData.positionName = "iOS Developer"
            postData.recruitNumbers = 10
            postData.workplaceLocation = "USA"
            postData.startDate = Date()
            postData.endDate = Date(timeInterval: 259200, since: postData.startDate ?? Date())
            postData.webLink = URL(string: "https://www.apple.com")
        }
        
        let fetchRequest = JobPosting.fetchRequest()
        let result = try persistenceController.managedObjectContext.fetch(fetchRequest)
        print(result)
        
        // XCTAssertTrue(result.count != 0)
    }

}
