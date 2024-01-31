//
//  GJTestRecordRepository.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/27/24.
//

import Foundation
import CoreData


final class GJTestRecordRepository: GJRepository {
    
    typealias Entity = GJTestRecord
    
    private let persistenceController: PersistenceController
    private var managedObjectContext: NSManagedObjectContext {
        persistenceController.managedObjectContext
    }
    
    init(persistenceController: PersistenceController = .shared) {
        self.persistenceController = persistenceController
    }
    
    func fetchAll() throws -> [GJTestRecord] {
        let fetchRequest = CDTestRecord.fetchRequest()
        fetchRequest.predicate = NSPredicate(value: true)
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(keyPath: \CDTestRecord.createdAt_, ascending: false)
        ]
        
        let fetchedResults = try managedObjectContext.fetch(fetchRequest)
        
        return fetchedResults.map { $0.convertToGJTestRecord() }
    }
    
    func fetch(objectsWith ids: [UUID]) throws -> [GJTestRecord] {
        let fetchRequest = CDTestRecord.fetchRequest()
        fetchRequest.predicate = NSPredicate(
            format: "id_ IN %@", ids)
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(keyPath: \CDTestRecord.createdAt_, ascending: false)
        ]
        
        let fetchedResults = try managedObjectContext.fetch(fetchRequest)
        
        return fetchedResults.map { $0.convertToGJTestRecord() }
    }
    
    func create(object: GJTestRecord) throws -> GJTestRecord {
        let jobApplicationFetchRequest = CDJobApplication.fetchRequest()
        jobApplicationFetchRequest.predicate = NSPredicate(
            format: "id_ = %@",
            object.jobApplicationId as CVarArg
        )
        
        let fetchedJobApplications = try managedObjectContext.fetch(jobApplicationFetchRequest)
        guard let fetchedJobApplication = fetchedJobApplications.first else {
            throw GJTestRecordRepositoryError.jobApplicationNotFound
        }
        
        let testFetchRequest = CDTest.fetchRequest()
        testFetchRequest.predicate = NSPredicate(
            format: "id_ = %@",
            object.testId as CVarArg
        )
        
        let fetchedTests = try managedObjectContext.fetch(testFetchRequest)
        guard let fetchedTest = fetchedTests.first else {
            throw GJTestRecordRepositoryError.testNotFound
        }
        
        let createdTestRecord = CDTestRecord(
            memo: object.memo,
            jobApplication: fetchedJobApplication,
            test: fetchedTest,
            context: managedObjectContext
        )
        
        try managedObjectContext.save()
        
        return createdTestRecord.convertToGJTestRecord()
    }
    
    func update(objectWith id: UUID, to object: GJTestRecord) throws -> GJTestRecord {
        
        let jobApplicationFetchRequest = CDJobApplication.fetchRequest()
        jobApplicationFetchRequest.predicate = NSPredicate(
            format: "%K = %@",
            \CDJobApplication.id_ as! CVarArg,
            object.jobApplicationId as CVarArg
        )
        
        let fetchedJobApplications = try managedObjectContext.fetch(jobApplicationFetchRequest)
        guard let fetchedJobApplication = fetchedJobApplications.first else {
            throw GJTestRecordRepositoryError.jobApplicationNotFound
        }
        
        let testFetchRequest = CDTest.fetchRequest()
        testFetchRequest.predicate = NSPredicate(
            format: "%K = %@",
            \CDTest.id_ as! CVarArg,
            object.testId as CVarArg
        )
        
        let fetchedTests = try managedObjectContext.fetch(testFetchRequest)
        guard let fetchedTest = fetchedTests.first else {
            throw GJTestRecordRepositoryError.testNotFound
        }
        
        let fetchRequest = CDTestRecord.fetchRequest()
        fetchRequest.predicate = NSPredicate(
            format: "%K = %@",
            \CDTestRecord.id_ as! CVarArg,
            id as CVarArg
        )
        
        let fetchedResults = try managedObjectContext.fetch(fetchRequest)
        guard let fetchedResult = fetchedResults.first else {
            throw GJTestRecordRepositoryError.testRecordNotFound
        }
        
        fetchedResult.jobApplication = fetchedJobApplication
        fetchedResult.test = fetchedTest
        fetchedResult.memo = object.memo
        
        try managedObjectContext.save()
        
        return fetchedResult.convertToGJTestRecord()
    }
    
    func delete(objectWith id: UUID) throws {
        let fetchRequest = CDTestRecord.fetchRequest()
        fetchRequest.predicate = NSPredicate(
            format: "id_ = %@",
            id as CVarArg
        )
        
        let fetchedResults = try managedObjectContext.fetch(fetchRequest)
        guard let fetchedResult = fetchedResults.first else {
            throw GJTestRecordRepositoryError.testRecordNotFound
        }
        
        managedObjectContext.delete(fetchedResult)
        
        try managedObjectContext.save()
    }
    
    enum GJTestRecordRepositoryError: Error {
        case jobApplicationNotFound
        case testNotFound
        case testRecordNotFound
    }
    
}

fileprivate extension CDTestRecord {
    
    func convertToGJTestRecord() -> GJTestRecord {
        GJTestRecord(
            id: self.id,
            createdAt: self.createdAt,
            jobApplicationId: self.jobApplication.id,
            testId: self.test.id,
            memo: self.memo
        )
    }
    
}
