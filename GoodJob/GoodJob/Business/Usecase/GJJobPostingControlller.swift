//
//  GJJobPostingControlller.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/17/24.
//

import Foundation
import CoreData


final class GJJobPostingControlller: NSObject, ObservableObject {
    
    private let controller: NSFetchedResultsController<CDJobPosting>
    
    var delegate: NSFetchedResultsControllerDelegate? {
        get { controller.delegate }
        set { controller.delegate = newValue }
    }
    
    var managedObjectContext: NSManagedObjectContext {
        controller.managedObjectContext
    }
    
    init(managedObjectContext: NSManagedObjectContext) {
        let fetchRequest = CDJobPosting.fetchRequest()
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(keyPath: \CDJobPosting.createdAt_, ascending: false)
        ]
        
        controller = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: managedObjectContext,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        try? controller.performFetch()
        super.init()
    }
    
    var jobPostings: [GJJobPosting] {
        (controller.fetchedObjects ?? [])
            .map { $0.convertToGJJobPosting() }
    }
    
    func create(jobPosting: GJJobPosting) -> GJJobPosting {
        let newCompany = CDCompany(
            name: jobPosting.companyName,
            context: managedObjectContext
        )
        
        let newJobPosition = CDJobPosition(
            name: jobPosting.jobPositionName,
            workplaceLocation: jobPosting.workplaceLocation,
            recruitNumbers: Int(jobPosting.recruitNumbers) ?? .zero,
            startDate: jobPosting.startDate,
            endDate: jobPosting.endDate,
            context: managedObjectContext
        )
        
        let newTests = jobPosting.tests.enumerated().reduce(into: Set<CDTest>()) { (partialResult, enumeratedData) in
            let (index, test) = enumeratedData
            partialResult.insert(
                CDTest(
                    order: index,
                    name: test.name,
                    testType: CDTest.TestType(rawValue: test.type.rawValue) ?? .writtenTest,
                    context: managedObjectContext
                )
            )
        }
        
        let newJobPosting = CDJobPosting(
            link: jobPosting.link,
            company: newCompany,
            jobPosition: newJobPosition,
            tests: newTests,
            context: managedObjectContext
        )
        
        try? managedObjectContext.save()
        
        let result = newJobPosting.convertToGJJobPosting()
        return result
    }
    
    func fetchJobPostings(ids: [UUID]) -> [GJJobPosting] {
        guard let fetchedJobPostings = try? CDJobPosting.fetch(ids: ids, in: managedObjectContext) else {
            return .init()
        }
        
        let convertedJobPostings = fetchedJobPostings.map { $0.convertToGJJobPosting() }
        return convertedJobPostings
    }
    
    func deleteJobPostings(ids: [UUID]) {
        try? CDJobPosting.delete(ids: ids, in: managedObjectContext)
    }
    
}


fileprivate extension CDJobPosting {
    
    func convertToGJJobPosting() -> GJJobPosting {
        let convertedTests = Array(self.tests)
            .sorted { lhs, rhs in lhs.order < rhs.order }
            .map { $0.convertToGJTest() }
    
        return GJJobPosting(
            id: self.id,
            companyName: self.company.name,
            jobPositionName: self.jobPosition.name,
            workplaceLocation: self.jobPosition.workplaceLocation,
            recruitNumbers: String(self.jobPosition.recruitNumbers),
            link: self.link,
            startDate: self.jobPosition.startDate,
            endDate: self.jobPosition.endDate,
            tests: convertedTests
        )
    }
    
}

fileprivate extension CDTest {
    
    func convertToGJTest() -> GJTest {
        let testType = GJTest.TestType(rawValue: self.testType.rawValue) ?? .writtenTest
        
        return GJTest(
            id: self.id,
            name: self.name,
            type: testType
        )
    }
    
}
