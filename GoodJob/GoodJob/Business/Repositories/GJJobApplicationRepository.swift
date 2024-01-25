//
//  GJJobApplicationRepository.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/25/24.
//

import Foundation
import CoreData


final class GJJobApplicationRepository: GJRepository {
    
    typealias Entity = GJJobApplication
    
    private let persistenceController: PersistenceController
    
    init(persistenceController: PersistenceController = .shared) {
        self.persistenceController = persistenceController
    }
    
    private var managedObjectContext: NSManagedObjectContext {
        persistenceController.managedObjectContext
    }
    
    func fetchAll() throws -> [GJJobApplication] {
        let fetchRequest = CDJobApplication.fetchRequest()
        fetchRequest.predicate = NSPredicate(value: true)
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(keyPath: \CDJobApplication.createdAt, ascending: false)
        ]
        
        let fetchedResults = try managedObjectContext.fetch(fetchRequest)
        return fetchedResults.map { $0.convertToGJJobApplication() }
    }
    
    func fetch(objectsWith ids: [UUID]) throws -> [GJJobApplication] {
        let fetchRequest = CDJobApplication.fetchRequest()
        fetchRequest.predicate = NSPredicate(
            format: "id_ IN %@", ids
        )
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(keyPath: \CDJobApplication.createdAt, ascending: false)
        ]
        
        let fetchedResults = try managedObjectContext.fetch(fetchRequest)
        return fetchedResults.map { $0.convertToGJJobApplication() }
    }
    
    func create(object: GJJobApplication) throws -> GJJobApplication {
        let userFetchRequest = CDUser.fetchRequest()
        userFetchRequest.predicate = NSPredicate(
            format: "id_ = %@", object.userId as CVarArg)
        
        let fetchedUsers = try managedObjectContext.fetch(userFetchRequest)
        guard let fetchedUser = fetchedUsers.first else {
            throw GJJobApplicationRepositoryError.userNotFound
        }
        
        let jobPostingFetchRequest = CDJobPosting.fetchRequest()
        jobPostingFetchRequest.predicate = NSPredicate(
            format: "id_ = %@", object.jobPostingId as CVarArg)
        
        let fetchedJobPostings = try managedObjectContext.fetch(jobPostingFetchRequest)
        guard let fetchedJobPosting = fetchedJobPostings.first else {
            throw GJJobApplicationRepositoryError.jobPostingNotFound
        }
        
        let createdJobApplication = CDJobApplication(
            title: object.title,
            user: fetchedUser,
            jobPosting: fetchedJobPosting,
            testRecords: .init(),
            context: managedObjectContext
        )
        
        try managedObjectContext.save()
        
        return createdJobApplication.convertToGJJobApplication()
    }
    
    func update(objectWith id: UUID, to object: GJJobApplication) throws -> GJJobApplication {
        let jobApplicationFetchRequest = CDJobApplication.fetchRequest()
        jobApplicationFetchRequest.predicate = NSPredicate(
            format: "id_ = ", id as CVarArg)
        
        let jobApplicationFetchedResults = try managedObjectContext.fetch(jobApplicationFetchRequest)
        guard let jobApplicationFetchedResult = jobApplicationFetchedResults.first else {
            throw GJJobApplicationRepositoryError.jobApplicationNotFound
        }
        
        jobApplicationFetchedResult.title = object.title
        
        let jobPostingFetchRequest = CDJobPosting.fetchRequest()
        jobPostingFetchRequest.predicate = NSPredicate(
            format: "id_ = %@", object.jobPostingId as CVarArg)
        
        let fetchedJobPostings = try managedObjectContext.fetch(jobPostingFetchRequest)
        guard let fetchedJobPosting = fetchedJobPostings.first else {
            throw GJJobApplicationRepositoryError.jobPostingNotFound
        }
        
        jobApplicationFetchedResult.jobPosting = fetchedJobPosting
        
        try managedObjectContext.save()
        
        return jobApplicationFetchedResult.convertToGJJobApplication()
    }
    
    func delete(objectWith id: UUID) throws {
        let fetchRequest = CDJobApplication.fetchRequest()
        fetchRequest.predicate = NSPredicate(
            format: "id_ = %@", id as CVarArg
        )
        
        let fetchedResults = try managedObjectContext.fetch(fetchRequest)
        guard let fetchedResult = fetchedResults.first else {
            throw GJJobApplicationRepositoryError.jobApplicationNotFound
        }
        
        managedObjectContext.delete(fetchedResult)
        
        try managedObjectContext.save()
    }
    
    enum GJJobApplicationRepositoryError: Error {
        case jobApplicationNotFound
        case userNotFound
        case jobPostingNotFound
    }
    
}

fileprivate extension CDJobApplication {
    
    func convertToGJJobApplication() -> GJJobApplication {
        GJJobApplication(
            id: self.id,
            title: self.title, 
            createdAt: self.createdAt,
            jobPostingId: self.jobPosting.id,
            userId: self.user.id,
            testRecords: self.testRecords.reduce(into: Set<UUID>()) {
                $0.insert($1.id)
            }
        )
    }
    
}
