//
//  GJUserController.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/20/24.
//

import Foundation
import CoreData


final class GJUserController {
    
    static let shared: GJUserController = .init()
    
    private var currentUser: CDUser?
    
    private let persistencController: PersistenceController
    private var managedObjectContext: NSManagedObjectContext {
        persistencController.managedObjectContext
    }
    
    init(persistenceController: PersistenceController = .shared) {
        self.persistencController = persistenceController
        self.currentUser = Self.createUserOnFirstLaunch(
            persistenceController: persistenceController
        )
    }
    
    private static func createUserOnFirstLaunch(persistenceController: PersistenceController) -> CDUser? {
        let managedObjectContext = persistenceController.managedObjectContext
        
        let fetchRequest = CDUser.fetchRequest()
        let fetchedUsers = try? managedObjectContext.fetch(fetchRequest)
        
        guard let user = fetchedUsers?.first else {
            let username = "User" + String(Int.random(in: 1000...9999))
            return CDUser(
                name: username,
                jobApplications: .init(),
                context: managedObjectContext
            )
        }
        
        return user
    }
    
}


// MARK: User Handler

extension GJUserController {
    
    var current: GJUser? {
        currentUser?.convertToGJUser()
    }
    
    func create(user: GJUser) -> GJUser {
        let newUser = CDUser(
            name: user.name,
            jobApplications: .init(),
            context: managedObjectContext
        )
        
        try? managedObjectContext.save()
        
        return newUser.convertToGJUser()
    }
    
    func fetchUsers(ids: [UUID]) -> [GJUser] {
        guard let fetchedUsers = try? CDUser.fetch(ids: ids, in: managedObjectContext) else {
            return []
        }
        
        let convertedUsers = fetchedUsers.map { $0.convertToGJUser() }
        return convertedUsers
    }
    
}
