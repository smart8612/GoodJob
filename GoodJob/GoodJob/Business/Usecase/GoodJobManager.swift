//
//  GoodJobManager.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/17/24.
//

import Foundation
import CoreData


final class GoodJobManager: NSObject, ObservableObject {
    
    private let persistenceController: PersistenceController
    
    private let jobPostingController: CDJobPostingFetchedResultsControlller
    
    init(persistenceController: PersistenceController = PersistenceController.shared) {
        self.persistenceController = persistenceController
        self.jobPostingController = CDJobPostingFetchedResultsControlller(
            managedObjectContext: persistenceController.managedObjectContext
        )
        super.init()
        jobPostingController.delegate = self
    }
    
    private var managedObjectContext: NSManagedObjectContext {
        persistenceController.managedObjectContext
    }
    
    var jobPostings: [GJJobPosting] {
        jobPostingController.jobPostings.map { $0.convertToGJJobPosting()}
    }
    
    @discardableResult
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
    
    func deleteJobPostings(on offsets: IndexSet) {
        let postIds = offsets.compactMap { jobPostings[$0].id }
        try? CDJobPosting.delete(ids: postIds, in: managedObjectContext)
    }
    
}


extension GoodJobManager: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        objectWillChange.send()
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
