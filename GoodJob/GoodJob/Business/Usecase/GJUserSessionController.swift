//
//  GJUserSessionController.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/20/24.
//

import Foundation


final class GJUserSessionController {
    
    static let shared: GJUserSessionController = .init()
    
    private let userRepository: any GJRepository<GJUser>
    private var currentUserId: UUID?
    
    var currentUser: GJUser? {
        guard let currentUserId = currentUserId else {
            return nil
        }
        let user = try? userRepository.fetch(objectsWith: [currentUserId]).first
        return user
    }
    
    init(userRepository: any GJRepository<GJUser> = GJUserRepository()) {
        self.userRepository = userRepository
        let user = try? createUserIfNotExist()
        self.currentUserId = user?.id
    }
    
    private func createUserIfNotExist() throws -> GJUser {
        let registeredUser = try userRepository.fetchAll().first
        
        guard let registeredUser = registeredUser else {
            let username = "User" + String(Int.random(in: 1000...9999))
            
            let createdUser = try userRepository.create(object: .init(
                name: username,
                jobApplicationIds: .init()
            ))
            
            return createdUser
        }
        
        return registeredUser
    }
    
}
