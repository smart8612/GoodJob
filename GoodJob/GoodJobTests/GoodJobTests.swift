//
//  GoodJobTests.swift
//  GoodJobTests
//
//  Created by JeongTaek Han on 1/15/24.
//

import XCTest
@testable import GoodJob


final class GoodJobTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_JobApplication_생성_검증() throws {
        // Given
        let jobPostingRepo = GJJobPostingRepository(persistenceController: .sharedForUnitTest)
        let jobApplicationRepo = GJJobApplicationRepository(persistenceController: .sharedForUnitTest)
        let user = GJUserSessionController(userRepository: GJUserRepository(persistenceController: .sharedForUnitTest))
        
        // When
        let createdJobPosting = try jobPostingRepo.create(object: .init(
            link: "https://www.apple.com",
            companyName: "Apple",
            jobPositionName: "iOS Developer",
            workplaceLocation: "USA",
            recruitNumbers: "10",
            startDate: .now,
            endDate: Date(timeIntervalSinceNow: 259200),
            testIds: .init()
        ))
        
        let createdJobApplication = try jobApplicationRepo.create(object: .init(
            title: "My Job Application",
            jobPostingId: createdJobPosting.id,
            userId: user.currentUser?.id ?? .init()
        ))
        
        print(createdJobApplication)
        
        XCTFail()
        
        
    }
    


//    
//    func test_생성된_User와_JobPosting에_종속된_JobApplication_신규_생성_검증() throws {
//        // Given
//        let createdJobPosting = model.create(jobPosting: .init(
//            companyName: "Apple",
//            jobPositionName: "iOS Developer",
//            workplaceLocation: "USA",
//            recruitNumbers: "10",
//            link: "https://www.apple.com",
//            startDate: .now,
//            endDate: Date(timeIntervalSinceNow: 259200),
//            tests: [
//                .init(name: "first written test", type: .writtenTest),
//                .init(name: "second meeting interview test", type: .inteview)
//            ])
//        )
//        
//        // When
//        let createdJobApplication = model.create(jobApplication: .init(
//            jobPostingId: createdJobPosting.id,
//            title: "My Job Application"
//        ))
//        guard let fetchedJobApplication = model.fetchJobApplications(ids: [createdJobApplication.id]).first else {
//            XCTFail()
//            return
//        }
//        
//        // Then
//        XCTAssertTrue(
//            fetchedJobApplication.title == createdJobApplication.title &&
//            fetchedJobApplication.jobPostingId == createdJobApplication.jobPostingId
//        )
//    }
//    
//    func test_JobApplication_등록_가능_JobPosting_명단_조회_검증() throws {
//        // Given
//        let createdJobPostings: [GJJobPosting] = [
//            .init(
//                companyName: "Apple",
//                jobPositionName: "iOS Developer",
//                workplaceLocation: "USA",
//                recruitNumbers: "10",
//                link: "https://www.apple.com",
//                startDate: .now,
//                endDate: Date(timeIntervalSinceNow: 259200),
//                tests: [
//                    .init(name: "first written test", type: .writtenTest),
//                    .init(name: "second meeting interview test", type: .inteview)
//                ]),
//            .init(
//                companyName: "Samsung",
//                jobPositionName: "Android Developer",
//                workplaceLocation: "Seoul",
//                recruitNumbers: "100",
//                link: "https://www.samsung.com",
//                startDate: .now,
//                endDate: Date(timeIntervalSinceNow: 259200),
//                tests: [
//                    .init(name: "first written test", type: .writtenTest),
//                    .init(name: "second meeting interview test", type: .inteview)
//                ])
//        ].map { model.create(jobPosting: $0) }
//        
//        // When
//        guard let applePost = createdJobPostings.first else {
//            XCTFail()
//            return
//        }
//        let createdJobApplication = model.create(jobApplication: .init(
//            jobPostingId: applePost.id,
//            title: "Apple Job Position Application"
//        ))
//        
//        // Then
//        // 삼성 포스트만 명단에 보여야 한다.
//        let result = model.fetchJobApplicationRegistableJobPostings()
//        print(result)
//        XCTAssert(!result.isEmpty)
//    }
//    
//    func test_특정_JobApplication의_Test에_TestRecord_생성_검증() throws {
//        // Given
//        let createdJobPosting = model.create(jobPosting: .init(
//            companyName: "Apple",
//            jobPositionName: "iOS Developer",
//            workplaceLocation: "USA",
//            recruitNumbers: "10",
//            link: "https://www.apple.com",
//            startDate: .now,
//            endDate: Date(timeIntervalSinceNow: 259200),
//            tests: [
//                .init(name: "first written test", type: .writtenTest),
//                .init(name: "second meeting interview test", type: .inteview)
//            ])
//        )
//        
//        let createdJobApplication = model.create(jobApplication: .init(
//            jobPostingId: createdJobPosting.id,
//            title: "Apple Job Application"
//        ))
//        
//        // When
//        // JobPosting의 0번 테스트에 대한 메모를 생성하면
//        let createdTestRecord = model.create(testRecord: .init(
//            jobApplicationId: createdJobApplication.id,
//            testId: createdJobPosting.tests[0].id,
//            memo: "Hello World"
//        ))
//        
//        // Then
//        // 특정 JobApplication의 테스트에 대한 기록 명단을 조회할 수 있다.
//        let fetchedTestRecords = model.fetchTestRecords(
//            jobApplicationId: createdTestRecord.jobApplicationId,
//            testId: createdTestRecord.testId
//        ).first!
//        
//        XCTAssertTrue(
//            createdTestRecord == fetchedTestRecords &&
//            createdTestRecord.memo == "Hello World"
//        )
//    }

}
