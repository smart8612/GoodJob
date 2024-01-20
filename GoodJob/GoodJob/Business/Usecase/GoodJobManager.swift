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
    private let jobApplicationController: CDJobApplicationFetchedResultsControlller
    
    init(persistenceController: PersistenceController = PersistenceController.shared) {
        self.persistenceController = persistenceController
        
        self.jobPostingController = CDJobPostingFetchedResultsControlller(
            managedObjectContext: persistenceController.managedObjectContext
        )
        self.jobApplicationController = CDJobApplicationFetchedResultsControlller(
            managedObjectContext: persistenceController.managedObjectContext
        )
        
        super.init()
        
        jobPostingController.delegate = self
        jobApplicationController.delegate = self
    }
    
    private var managedObjectContext: NSManagedObjectContext {
        persistenceController.managedObjectContext
    }
    
    static func initWithPreview() -> Self {
        let model = Self.init(persistenceController: .init(inMemory: true))
        
        let post = model.create(jobPosting: .init(
            companyName: "Apple",
            jobPositionName: "iOS Developer",
            workplaceLocation: "USA",
            recruitNumbers: "100",
            link: "https://www.apple.com",
            startDate: .now,
            endDate: .init(timeIntervalSinceNow: 259200),
            tests: [
                .init(name: "test1", type: .writtenTest),
                .init(name: "test2", type: .inteview)
            ]
        ))
        
        let user = model.create(user: .init(name: "singularis7"))
        let _ = model.create(jobApplication: .init(
            jobPostingId: post.id,
            userId: user.id,
            title: "My Job Application"
        ))
        
        return model
    }
    
}

// MARK: JobApplication Handler {

extension GoodJobManager {
    
    var jobApplications: [GJJobApplication] {
        jobApplicationController.jobApplications.map { $0.convertToGJJobApplication() }
    }
    
    func create(jobApplication: GJJobApplication) -> GJJobApplication {
        let fetchedUser = try! CDUser.fetch(ids: [jobApplication.userId], in: managedObjectContext).first!
        let fetchedJobPosting = try! CDJobPosting.fetch(ids: [jobApplication.jobPostingId], in: managedObjectContext).first!
        
        let newJobApplication = CDJobApplication(
            title: jobApplication.title,
            user: fetchedUser,
            jobPosting: fetchedJobPosting,
            testRecords: .init(),
            context: managedObjectContext
        )
        
        try? managedObjectContext.save()
        
        return newJobApplication.convertToGJJobApplication()
    }
    
    func fetchJobApplications(ids: [UUID]) -> [GJJobApplication] {
        guard let fetchedJobApplications = try? CDJobApplication.fetch(ids: ids, in: managedObjectContext) else {
            return []
        }
        
        let convertedJobApplications = fetchedJobApplications.map { $0.convertToGJJobApplication() }
        return convertedJobApplications
    }
    
    
}

// MARK: User Handler

extension GoodJobManager {
    
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

// MARK: JobPosting Handler

extension GoodJobManager {
    
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

// MARK: Entity Converter

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

fileprivate extension CDUser {
    
    func convertToGJUser() -> GJUser {
        GJUser(id: self.id, name: self.name)
    }
    
}

fileprivate extension CDJobApplication {
    
    func convertToGJJobApplication() -> GJJobApplication {
        GJJobApplication(
            id: self.id,
            jobPostingId: self.jobPosting.id,
            userId: self.user.id,
            title: self.title,
            createdAt: self.createdAt
        )
    }
    
}
