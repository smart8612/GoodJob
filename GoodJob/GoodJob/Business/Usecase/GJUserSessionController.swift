//
//  GJUserSessionController.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/20/24.
//

import Foundation


final class GJUserSessionController {
    
    static let shared: GJUserSessionController = .init()
    
    private let userRepository: GJUserRepository
    private var currentUser: GJUser?
    
    init(userRepository: GJUserRepository = .init(persistenceController: .shared)) {
        self.userRepository = userRepository
        self.currentUser = try? createUserIfNotExist()
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
