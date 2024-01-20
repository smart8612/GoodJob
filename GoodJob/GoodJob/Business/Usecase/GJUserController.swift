//
//  GJUserController.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/20/24.
//

import Foundation
import CoreData


final class GJUserController {
    
    private(set) var current: CDUser
    
    private let managedObjectContext: NSManagedObjectContext
    
    init(managedObjectContext: NSManagedObjectContext) {
        self.managedObjectContext = managedObjectContext
        
        let fetchRequest = CDUser.fetchRequest()
        let fetchedUsers = try? managedObjectContext.fetch(fetchRequest)
        
        guard let user = fetchedUsers?.first else {
            self.current = Self.createUserIfNeeded(context: managedObjectContext)
            return
        }
        
        self.current = user
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
