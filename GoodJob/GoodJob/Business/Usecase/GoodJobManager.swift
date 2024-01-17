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
    
    private var managedObectContext: NSManagedObjectContext {
        persistenceController.managedObjectContext
    }
    
    var jobPostings: [GJJobPosting] {
        jobPostingController.jobPostings
            .map {
                GJJobPosting(
                    id: $0.id,
                    companyName: $0.company.name,
                    jobPostitionName: $0.positionName,
                    workplaceLocation: $0.workplaceLocation,
                    recruitNumbers: String($0.recruitNumbers),
                    link: $0.webLink,
                    startDate: $0.startDate,
                    endDate: $0.endDate
                )
            }
    }
    
    func create(jobPosting: GJJobPosting) {
        let newCompany = CDCompany(
            name: jobPosting.companyName,
            context: managedObectContext
        )
        
        let newJobPosting = CDJobPosting(
            company: newCompany,
            positionName: jobPosting.jobPostitionName,
            workplaceLocation: jobPosting.workplaceLocation,
            recruitNumbers: Int(jobPosting.recruitNumbers) ?? .zero,
            webLink: jobPosting.link,
            startDate: jobPosting.startDate,
            endDate: jobPosting.endDate,
            context: managedObectContext
        )
        
        try? managedObectContext.save()
    }
    
    func deleteJobPostings(on offsets: IndexSet) {
        let postIds = offsets
            .compactMap { jobPostings[$0].id }
            .reduce(into: Set<UUID>()) { $0.insert($1) }
        
        jobPostingController.jobPostings
            .filter { postIds.contains($0.id) }
            .forEach { managedObectContext.delete($0) }
    }
    
}


extension GoodJobManager: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        objectWillChange.send()
    }
    
}
