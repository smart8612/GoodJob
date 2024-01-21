//
//  GJUserController.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/20/24.
//

import Foundation
import CoreData


final class GJUserController {
    
    private var currentUser: CDUser
    
    private let managedObjectContext: NSManagedObjectContext
    
    init(managedObjectContext: NSManagedObjectContext) {
        self.managedObjectContext = managedObjectContext
        
        let fetchRequest = CDUser.fetchRequest()
        let fetchedUsers = try? managedObjectContext.fetch(fetchRequest)
        
        guard let user = fetchedUsers?.first else {
            self.currentUser = Self.createUserIfNeeded(context: managedObjectContext)
            return
        }
        
        self.currentUser = user
    }
    
    private static func createUserIfNeeded(context: NSManagedObjectContext) -> CDUser {
        let username = "User" + String(Int.random(in: 1000...9999))
        return CDUser(
            name: username,
            jobApplications: .init(),
            context: context
        )
    }
    
}


// MARK: User Handler

extension GJUserController {
    
    var current: GJUser {
        currentUser.convertToGJUser()
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

fileprivate extension CDUser {
    
    func convertToGJUser() -> GJUser {
        GJUser(id: self.id, name: self.name)
    }
    
}
