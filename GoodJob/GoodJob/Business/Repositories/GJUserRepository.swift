//
//  GJUserRepository.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/23/24.
//

import Foundation
import CoreData


final class GJUserRepository: GJRepository {
    
    typealias Entity = GJUser
    
    private let persistenceController: PersistenceController
    private var managedObjectContext: NSManagedObjectContext {
        persistenceController.managedObjectContext
    }
    
    init(persistenceController: PersistenceController = .shared) {
        self.persistenceController = persistenceController
    }
    
    func fetchAll() throws -> [GJUser] {
        let fetchRequest = CDUser.fetchRequest()
        fetchRequest.predicate = NSPredicate(value: true)
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(keyPath: \CDUser.name_, ascending: true)
        ]
        
        let fetchedUsers = try managedObjectContext.fetch(fetchRequest)
        
        return fetchedUsers.map { $0.convertToGJUser() }
    }
    
    func fetch(objectsWith ids: [UUID]) throws -> [GJUser] {
        let fetchRequest = CDUser.fetchRequest()
        fetchRequest.predicate = NSPredicate(
            format: "id_ IN %@", ids
        )
        
        let fetchedResults = try managedObjectContext.fetch(fetchRequest)
        
        return fetchedResults.map { $0.convertToGJUser() }
    }
    
    func create(object: Entity) throws -> GJUser {
        let createdUser = CDUser(
            name: object.name,
            jobApplications: .init(),
            context: managedObjectContext
        )
        
        try managedObjectContext.save()
        
        return createdUser.convertToGJUser()
    }
    
    func update(objectWith id: UUID, to object: GJUser) throws -> Entity {
        let userFetchRequest = CDUser.fetchRequest()
        userFetchRequest.predicate = NSPredicate(
            format: "id_ = %@", id as CVarArg
        )
        
        let fetchedUsers = try managedObjectContext.fetch(userFetchRequest)
        guard let targetUser = fetchedUsers.first else {
            throw UserRepositoryError.userNotFound
        }
        
        let jobApplicationFetchRequest = CDJobApplication.fetchRequest()
        userFetchRequest.predicate = NSPredicate(
            format: "id_ IN %@", object.jobApplicationIds
        )
        
        let fetchedJobApplications = try managedObjectContext.fetch(jobApplicationFetchRequest)
        
        targetUser.name = object.name
        targetUser.jobApplications = Set(fetchedJobApplications)
        
        try managedObjectContext.save()
        
        return targetUser.convertToGJUser()
    }
    
    func delete(objectWith id: UUID) throws {
        let fetchRequest = CDUser.fetchRequest()
        fetchRequest.predicate = NSPredicate(
            format: "id_ = %@", id as CVarArg
        )
        
        let fetchedUsers = try managedObjectContext.fetch(fetchRequest)
        
        guard let targetUser = fetchedUsers.first else {
            throw UserRepositoryError.userNotFound
        }
        
        managedObjectContext.delete(targetUser)
        
        try managedObjectContext.save()
    }
    
    enum UserRepositoryError: Error {
        case userNotFound
    }
    
}


fileprivate extension CDUser {
    
    func convertToGJUser() -> GJUser {
        let jobApplicationIds = self.jobApplications
            .reduce(into: Set<UUID>()) { $0.insert($1.id) }
        
        return GJUser(
            id: self.id,
            name: self.name,
            jobApplicationIds: jobApplicationIds
        )
    }
    
}
