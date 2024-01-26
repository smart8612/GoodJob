//
//  GJJobPostingRepository.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/23/24.
//

import Foundation
import CoreData


final class GJJobPostingRepository: GJRepository {
    
    typealias Entity = GJJobPosting
    
    private let persistenceController: PersistenceController
    private var managedObjectContext: NSManagedObjectContext {
        persistenceController.managedObjectContext
    }
    
    init(persistenceController: PersistenceController = .shared) {
        self.persistenceController = persistenceController
    }
    
    func fetchAll() throws -> [GJJobPosting] {
        let fetchRequest = CDJobPosting.fetchRequest()
        fetchRequest.predicate = NSPredicate(value: true)
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(key: "createdAt_", ascending: false)
        ]
        
        let fetchedResults = try managedObjectContext.fetch(fetchRequest)
        
        return fetchedResults.map { $0.convertToGJJobPosting() }
    }
    
    func fetch(objectsWith ids: [UUID]) throws -> [GJJobPosting] {
        let fetchRequest = CDJobPosting.fetchRequest()
        fetchRequest.predicate = NSPredicate(
            format: "id_ IN %@", ids
        )
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(key: "createdAt_", ascending: false)
        ]
        
        let fetchedResult = try managedObjectContext.fetch(fetchRequest)
        
        return fetchedResult.map { $0.convertToGJJobPosting() }
    }
    
    func create(object: GJJobPosting) throws -> GJJobPosting {
        let createdCompany = CDCompany(
            name: object.companyName,
            context: managedObjectContext
        )
        
        let createdJobPosition = CDJobPosition(
            name: object.jobPositionName,
            workplaceLocation: object.workplaceLocation,
            recruitNumbers: Int(object.recruitNumbers) ?? .zero,
            startDate: object.startDate,
            endDate: object.endDate,
            context: managedObjectContext
        )
        
        let createdJobPosting = CDJobPosting(
            link: object.link,
            company: createdCompany,
            jobPosition: createdJobPosition,
            tests: .init(),
            context: managedObjectContext
        )
        
        try managedObjectContext.save()
        
        return createdJobPosting.convertToGJJobPosting()
    }
    
    func update(objectWith id: UUID, to object: GJJobPosting) throws -> GJJobPosting {
        let fetchRequest = CDJobPosting.fetchRequest()
        fetchRequest.predicate = NSPredicate(
            format: "id_ = %@", id as CVarArg
        )
        
        let fetchedJobPostings = try managedObjectContext.fetch(fetchRequest)
        guard let fetchedJobPosting = fetchedJobPostings.first else {
            throw GJJobPostingRepositoryError.jobPostingNotFound
        }
        
        fetchedJobPosting.link = object.link
        fetchedJobPosting.createdAt = object.createdAt
        
        fetchedJobPosting.company.name = object.companyName
        
        fetchedJobPosting.jobPosition.name = object.jobPositionName
        fetchedJobPosting.jobPosition.workplaceLocation = object.workplaceLocation
        fetchedJobPosting.jobPosition.recruitNumbers = Int(object.recruitNumbers) ?? .zero
        fetchedJobPosting.jobPosition.startDate = object.startDate
        fetchedJobPosting.jobPosition.endDate = object.endDate
        
        try managedObjectContext.save()
        
        return fetchedJobPosting.convertToGJJobPosting()
    }
    
    func delete(objectWith id: UUID) throws {
        let fetchRequest = CDJobPosting.fetchRequest()
        fetchRequest.predicate = NSPredicate(
            format: "id_ = %@", id as CVarArg
        )
        
        let fetchedJobPostings = try managedObjectContext.fetch(fetchRequest)
        guard let fetchedJobPosting = fetchedJobPostings.first else {
            throw GJJobPostingRepositoryError.jobPostingNotFound
        }
        
        managedObjectContext.delete(fetchedJobPosting)
        
        try managedObjectContext.save()
    }
    
    enum GJJobPostingRepositoryError: Error {
        case jobPostingNotFound
    }
    
}


fileprivate extension CDJobPosting {
    
    func convertToGJJobPosting() -> GJJobPosting {
        GJJobPosting(
            id: self.id,
            link: self.link,
            createdAt: self.createdAt,
            companyName: self.company.name,
            jobPositionName: self.jobPosition.name,
            workplaceLocation: self.jobPosition.workplaceLocation,
            recruitNumbers: String(self.jobPosition.recruitNumbers),
            startDate: self.jobPosition.startDate,
            endDate: self.jobPosition.endDate,
            testIds: self.tests.reduce(into: Set<UUID>()) {
                $0.insert($1.id)
            },
            jobApplicationId: self.jobApplication?.id
        )
    }
    
}
