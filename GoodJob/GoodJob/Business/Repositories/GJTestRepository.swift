//
//  GJTestRepository.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/24/24.
//

import Foundation
import CoreData


final class GJTestRepository: GJRepository {
    
    typealias Entity = GJTest
    
    private let persistenceController: PersistenceController
    private var managedObjectContext: NSManagedObjectContext {
        persistenceController.managedObjectContext
    }
    
    init(persistenceController: PersistenceController = .shared) {
        self.persistenceController = persistenceController
    }
    
    func fetchAll() throws -> [GJTest] {
        let fetchRequest = CDTest.fetchRequest()
        fetchRequest.predicate = NSPredicate(value: true)
        
        let fetchedTests = try managedObjectContext.fetch(fetchRequest)
        
        return fetchedTests.map { $0.convertToGJTest() }
    }
    
    func fetch(objectsWith ids: [UUID]) throws -> [GJTest] {
        let fetchRequest = CDTest.fetchRequest()
        fetchRequest.predicate = NSPredicate(
            format: "id_ IN %@", ids
        )
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(key: "order_", ascending: true)
        ]
        
        let fetchedResults = try managedObjectContext.fetch(fetchRequest)
        
        return fetchedResults.map { $0.convertToGJTest() }
    }
    
    func create(object: GJTest) throws -> GJTest {
        let testType = CDTest.TestType(rawValue: object.type.rawValue) ?? .test
        
        let jobPostingFetchRequest = CDJobPosting.fetchRequest()
        jobPostingFetchRequest.predicate = NSPredicate(
            format: "id_ = %@", object.jobPostingId as CVarArg
        )
        
        let fetchedJobPostings = try managedObjectContext.fetch(jobPostingFetchRequest)
        guard let fetchedJobPosting = fetchedJobPostings.first else {
            throw GJTestRepositoryError.referencedJobPostingNotFound
        }
        
        let createdTest = CDTest(
            order: object.order,
            name: object.name,
            testType: testType,
            jobPosting: fetchedJobPosting,
            context: managedObjectContext
        )
        
        try managedObjectContext.save()
        
        return createdTest.convertToGJTest()
    }
    
    func update(objectWith id: UUID, to object: GJTest) throws -> GJTest {
        let fetchRequest = CDTest.fetchRequest()
        fetchRequest.predicate = NSPredicate(
            format: "id_ = %@", id as CVarArg
        )
        
        let fetchedResults = try managedObjectContext.fetch(fetchRequest)
        guard let fetchedTest = fetchedResults.first else {
            throw GJTestRepositoryError.testNotFound
        }
        
        fetchedTest.order = object.order
        fetchedTest.name = object.name
        
        let testType = CDTest.TestType(rawValue: object.type.rawValue) ?? .test
        fetchedTest.testType = testType
        
        try managedObjectContext.save()
        
        return fetchedTest.convertToGJTest()
    }
    
    func delete(objectWith id: UUID) throws {
        let fetchRequest = CDTest.fetchRequest()
        fetchRequest.predicate = NSPredicate(
            format: "id_ = %@", id as CVarArg
        )
        
        let fetchedResults = try managedObjectContext.fetch(fetchRequest)
        guard let fetchedTest = fetchedResults.first else {
            throw GJTestRepositoryError.testNotFound
        }
        
        managedObjectContext.delete(fetchedTest)
        
        try managedObjectContext.save()
    }
    
    enum GJTestRepositoryError: Error {
        case referencedJobPostingNotFound
        case testNotFound
    }
    
}


fileprivate extension CDTest {
    
    func convertToGJTest() -> GJTest {
        let testType = GJTest.TestType(rawValue: self.testType.rawValue) ?? .test
        return .init(
            id: self.id,
            order: self.order,
            name: self.name,
            type: testType,
            jobPostingId: self.jobPosting.id
        )
    }
    
}
