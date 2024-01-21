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
    private var model: GJAppController!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        persistenceController = PersistenceController(inMemory: true)
        model = GJAppController(persistenceController: persistenceController)
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
            endDate: Date(timeInterval: 259200, since: .now), 
            tests: []
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
            endDate: Date(timeInterval: 259200, since: .now),
            tests: []
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
            endDate: Date(timeInterval: 259200, since: .now), 
            tests: []
        )
        
        // When
        let _ = model.create(jobPosting: newJobPosting)
        model.deleteJobPostings(on: .init(integer: .zero))
        
        // Then
        let result = model.jobPostings
        XCTAssertTrue(result.count == 0)
    }
    
    func test_채용시험정보_Test_포함_JobPosting_생성_검증() {
        // Given
        let newTests = [
            GJTest(name: "first written test", type: .writtenTest),
            GJTest(name: "second meeting interview test", type: .inteview)
        ]
        
        let newJobPosting = GJJobPosting(
            companyName: "Apple",
            jobPositionName: "iOS Developer",
            workplaceLocation: "USA",
            recruitNumbers: "10",
            link: "https://www.apple.com",
            startDate: .now,
            endDate: Date(timeInterval: 259200, since: .now),
            tests: newTests
        )
        
        // When
        let createdJobPosting = model.create(jobPosting: newJobPosting)
        guard let fetchedJobPosting = model.fetchJobPostings(ids: [createdJobPosting.id]).first else {
            XCTFail()
            return
        }
        let fetchedTests = fetchedJobPosting.tests
        
        // Then
        XCTAssertTrue(
            fetchedTests[0].name == newTests[0].name &&
            fetchedTests[0].type == fetchedTests[0].type &&
            fetchedTests[1].name == newTests[1].name &&
            fetchedTests[1].type == newTests[1].type
        )
        
    }
    
    func test_로컬_사용자_신규_생성_검증() throws {
        // Given
        let newUser = GJUser(name: "singularis7")
        
        // When
        let createdUser = model.create(user: newUser)
        guard let fetchedUser = model.fetchUsers(ids: [createdUser.id]).first else {
            XCTFail()
            return
        }
        
        // Then
        XCTAssertTrue(createdUser.name == fetchedUser.name)
    }
    
    func test_생성된_User와_JobPosting에_종속된_JobApplication_신규_생성_검증() throws {
        // Given
        let createdJobPosting = model.create(jobPosting: .init(
            companyName: "Apple",
            jobPositionName: "iOS Developer",
            workplaceLocation: "USA",
            recruitNumbers: "10",
            link: "https://www.apple.com",
            startDate: .now,
            endDate: Date(timeIntervalSinceNow: 259200),
            tests: [
                .init(name: "first written test", type: .writtenTest),
                .init(name: "second meeting interview test", type: .inteview)
            ])
        )
        
        // When
        let createdJobApplication = model.create(jobApplication: .init(
            jobPostingId: createdJobPosting.id,
            title: "My Job Application"
        ))
        guard let fetchedJobApplication = model.fetchJobApplications(ids: [createdJobApplication.id]).first else {
            XCTFail()
            return
        }
        
        // Then
        XCTAssertTrue(
            fetchedJobApplication.title == createdJobApplication.title &&
            fetchedJobApplication.jobPostingId == createdJobApplication.jobPostingId
        )
    }
    
    func test_JobApplication_미등록_JobPosting_명단_조회_검증() throws {
        // Given
        let createdJobPostings: [GJJobPosting] = [
            .init(
                companyName: "Apple",
                jobPositionName: "iOS Developer",
                workplaceLocation: "USA",
                recruitNumbers: "10",
                link: "https://www.apple.com",
                startDate: .now,
                endDate: Date(timeIntervalSinceNow: 259200),
                tests: [
                    .init(name: "first written test", type: .writtenTest),
                    .init(name: "second meeting interview test", type: .inteview)
                ]),
            .init(
                companyName: "Samsung",
                jobPositionName: "Android Developer",
                workplaceLocation: "Seoul",
                recruitNumbers: "100",
                link: "https://www.samsung.com",
                startDate: .now,
                endDate: Date(timeIntervalSinceNow: 259200),
                tests: [
                    .init(name: "first written test", type: .writtenTest),
                    .init(name: "second meeting interview test", type: .inteview)
                ])
        ].map { model.create(jobPosting: $0) }
        
        // When
        guard let applePost = createdJobPostings.first else {
            XCTFail()
            return
        }
        let createdJobApplication = model.create(jobApplication: .init(
            jobPostingId: applePost.id,
            title: "Apple Job Position Application"
        ))
        
        // Then
        // 삼성 포스트만 명단에 보여야 한다.
        let result = model.fetchJobApplicationRegistableJobPostings()
        XCTAssert(!result.isEmpty)
        
        
    }

}
