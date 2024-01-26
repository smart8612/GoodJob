//
//  GoodJobUserTests.swift
//  GoodJobTests
//
//  Created by JeongTaek Han on 1/23/24.
//

import XCTest
@testable import GoodJob


final class GoodJobUserTests: XCTestCase {
    
    private var userRepository: GJUserRepository!
    private var userSessionController: GJUserSessionController!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.userRepository = GJUserRepository(persistenceController: .init(inMemory: true))
        self.userSessionController = GJUserSessionController(userRepository: userRepository)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.userRepository = nil
        self.userSessionController = nil
    }

    func test_사용자_생성_검증() throws {
        // Given
        let newUserName = "singularis7"
        
        // When
        let createdUser = try userRepository.create(object: .init(
            name: newUserName,
            jobApplicationIds: .init()
        ))
        
        // Then
        XCTAssertEqual(createdUser.name, newUserName)
    }
    
    func test_사용자_조회_검증() throws {
        // Given
        let newUserName = "singularis7"
        
        // When
        let createdUser = try userRepository.create(object: .init(
            name: newUserName,
            jobApplicationIds: .init()
        ))
        let fetchedUserResults = try userRepository.fetch(objectsWith: [createdUser.id])
        guard let fetchedUser = fetchedUserResults.first else {
            XCTFail()
            return
        }
        
        // Then
        XCTAssertEqual(fetchedUser, createdUser)
        XCTAssertEqual(fetchedUser.name, newUserName)
    }
    
    func test_사용자_수정_검증() throws {
        // Given
        let newUserName = "singularis7"
        
        // When
        var createdUser = try userRepository.create(object: .init(
            name: newUserName,
            jobApplicationIds: .init()
        ))
        let targetUserName = "smart8612"
        createdUser.name = targetUserName
        
        let updatedUser = try userRepository.update(objectWith: createdUser.id, to: createdUser)
        guard let fetchedUser = try userRepository.fetch(objectsWith: [updatedUser.id]).first else {
            XCTFail()
            return
        }
        
        // Then
        XCTAssertEqual(fetchedUser, updatedUser)
        XCTAssertEqual(fetchedUser.name, targetUserName)
    }
    
    func test_사용자_제거_검증() throws {
        // Given
        let newUserName = "singularis7"
        
        // When
        var createdUser = try userRepository.create(object: .init(
            name: newUserName,
            jobApplicationIds: .init()
        ))
        try userRepository.delete(objectWith: createdUser.id)
        let fetchedUsers = try userRepository.fetch(objectsWith: [createdUser.id])
        
        // Then
        XCTAssertTrue(fetchedUsers.isEmpty)
    }
    
    func test_등록된_사용자가_없을시_자동생성_검증() throws {
        // When
        let currentUser = userSessionController.currentUser
        
        // Then
        XCTAssertNotNil(currentUser)
    }

}
