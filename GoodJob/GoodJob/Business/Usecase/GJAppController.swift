//
//  GJAppController.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/17/24.
//

import Foundation
import CoreData


final class GJAppController: ObservableObject {
    
    private let persistenceController: PersistenceController
    
    init(persistenceController: PersistenceController = .init()) {
        self.persistenceController = persistenceController
    }
    
    private var managedObjectContext: NSManagedObjectContext {
        persistenceController.managedObjectContext
    }
    
//    static func initWithPreview() -> Self {
//        let model = Self.init(persistenceController: .init(inMemory: true))
//        
//        let post = model.create(jobPosting: .init(
//            companyName: "Apple",
//            jobPositionName: "iOS Developer",
//            workplaceLocation: "USA",
//            recruitNumbers: "100",
//            link: "https://www.apple.com",
//            startDate: .now,
//            endDate: .init(timeIntervalSinceNow: 259200),
//            tests: [
//                .init(name: "apple test1", type: .writtenTest),
//                .init(name: "apple test2", type: .inteview)
//            ]
//        ))
//        
//        let _ = model.create(jobPosting: .init(
//            companyName: "Samsung",
//            jobPositionName: "Android Developer",
//            workplaceLocation: "South Korea",
//            recruitNumbers: "100",
//            link: "https://www.samsung.com",
//            startDate: .init(timeIntervalSinceNow: 259200),
//            endDate: .init(timeIntervalSinceNow: 259200 * 2),
//            tests: [
//                .init(name: "samsung test1", type: .writtenTest),
//                .init(name: "samsung test2", type: .inteview)
//            ]
//        ))
//        
//        let _ = model.create(jobApplication: .init(
//            jobPostingId: post.id,
//            title: "My Job Application"
//        ))
//        
//        return model
//    }
    
}

// MARK: Test Record Handler

extension GJAppController {
    
//    func create(testRecord: GJTestRecord) -> GJTestRecord {
//        let fetchedJobApplications = try! CDJobApplication.fetch(
//            ids: [testRecord.jobApplicationId], in: managedObjectContext
//        )
//        
//        let fetchedJobApplication = fetchedJobApplications.first!
//        
//        let fetchedTests = try! CDTest.fetch(
//            ids: [testRecord.testId], in: managedObjectContext
//        )
//        
//        let fetchedTest = fetchedTests.first!
//        
//        let createdTestRecord = CDTestRecord(
//            memo: testRecord.memo,
//            jobApplication: fetchedJobApplication,
//            test: fetchedTest,
//            context: managedObjectContext
//        )
//        
//        try? managedObjectContext.save()
//        
//        return createdTestRecord.convertToGJTestRecord()
//    }
    
    func fetchTestRecords(jobApplicationId: UUID, testId: UUID) -> [GJTestRecord] {
        let fetchRequest = CDJobApplication.fetchRequest()
        fetchRequest.predicate = .init(
            format: "id_ = %@",
            jobApplicationId as CVarArg
        )
        
        let fetchedJobApplication = try! managedObjectContext.fetch(fetchRequest).first!
        
        let result = fetchedJobApplication.testRecords
        
        return result.map { $0.convertToGJTestRecord() }
    }
    
}

extension CDTestRecord {
    
    func convertToGJTestRecord() -> GJTestRecord {
        GJTestRecord(
            id: self.id,
            jobApplicationId: self.jobApplication.id,
            testId: self.test.id,
            memo: self.memo
        )
    }
    
}
