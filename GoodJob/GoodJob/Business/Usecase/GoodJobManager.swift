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
        jobPostingController.jobPostings
            .map {
                GJJobPosting(
                    id: $0.id,
                    companyName: $0.company.name,
                    jobPositionName: $0.jobPosition.name,
                    workplaceLocation: $0.jobPosition.workplaceLocation,
                    recruitNumbers: String($0.jobPosition.recruitNumbers),
                    link: $0.link,
                    startDate: $0.jobPosition.startDate,
                    endDate: $0.jobPosition.endDate
                )
            }
    }
    
    func create(jobPosting: GJJobPosting) {
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
        
        let newJobPosting = CDJobPosting(
            link: jobPosting.link,
            company: newCompany,
            jobPosition: newJobPosition,
            context: managedObjectContext
        )
        
        try? managedObjectContext.save()
    }
    
    func deleteJobPostings(on offsets: IndexSet) {
        let postIds = offsets
            .compactMap { jobPostings[$0].id }
            .reduce(into: Set<UUID>()) { $0.insert($1) }
        
        jobPostingController.jobPostings
            .filter { postIds.contains($0.id) }
            .forEach { managedObjectContext.delete($0) }
    }
    
}


extension GoodJobManager: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        objectWillChange.send()
    }
    
}
