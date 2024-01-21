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
        
        let _ = model.create(jobApplication: .init(
            jobPostingId: post.id,
            title: "My Job Application"
        ))
        
        return model
    }
    
}


// MARK: JobApplication Handler

extension GJAppController {
    
    var jobApplications: [GJJobApplication] {
        jobApplicationController.jobApplications
    }
    
    func create(jobApplication: GJJobApplication) -> GJJobApplication {
        return jobApplicationController.create(jobApplication: jobApplication, userId: currentUser.id)
    }
    
    func fetchJobApplications(ids: [UUID]) -> [GJJobApplication] {
        return jobApplicationController.fetchJobApplications(ids: ids)
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
    
    // MARK: To-Do
    
    func fetchJobApplicationRegistableJobPostings() -> [GJJobPosting]  {
        return jobPostingController.fetchJobApplicationRegistableJobPostings()
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
