//
//  GJAppController.swift
//  GoodJob
//
//  Created by JeongTaek Han on 1/17/24.
//

import Foundation
import CoreData


final class GJAppController: NSObject, ObservableObject {
    
    private let persistenceController: PersistenceController
    
    private let jobPostingController: GJJobPostingControlller
    private let jobApplicationController: GJJobApplicationControlller
    private let userController: GJUserController
    
    init(persistenceController: PersistenceController = PersistenceController.shared) {
        self.persistenceController = persistenceController
        
        self.jobPostingController = GJJobPostingControlller(
            managedObjectContext: persistenceController.managedObjectContext
        )
        self.jobApplicationController = GJJobApplicationControlller(
            managedObjectContext: persistenceController.managedObjectContext
        )
        self.userController = GJUserController(
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

extension GJAppController {
    
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

extension GJAppController {
    
    var currentUser: GJUser {
        userController.current
    }
    
    func create(user: GJUser) -> GJUser {
        return userController.create(user: user)
    }
    
    func fetchUsers(ids: [UUID]) -> [GJUser] {
        return userController.fetchUsers(ids: ids)
    }
    
}

// MARK: JobPosting Handler

extension GJAppController {
    
    var jobPostings: [GJJobPosting] {
        jobPostingController.jobPostings
    }
    
    @discardableResult
    func create(jobPosting: GJJobPosting) -> GJJobPosting {
        return jobPostingController.create(jobPosting: jobPosting)
    }
    
    func fetchJobPostings(ids: [UUID]) -> [GJJobPosting] {
        return jobPostingController.fetchJobPostings(ids: ids)
    }
    
    func deleteJobPostings(on offsets: IndexSet) {
        let postIds = offsets.compactMap { jobPostings[$0].id }
        jobPostingController.deleteJobPostings(ids: postIds)
    }
    
}

extension GJAppController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        objectWillChange.send()
    }
    
}

// MARK: Entity Converter

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
